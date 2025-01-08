import 'dart:convert';
import 'dart:math';
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:whatsevr_app/config/api/methods/tracked_activities.dart';
import 'package:whatsevr_app/config/api/requests_model/tracked_activity/track_activities.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';

import 'package:whatsevr_app/config/services/user_agent_info.dart';
import 'package:whatsevr_app/dev/talker.dart';
import 'package:whatsevr_app/utils/geopoint_wkb_parser.dart';

/// Caches GPS position to minimize location requests
/// Position is considered stale after 10 minutes
class _PositionCache {
  static Position? _cachedPosition;
  static DateTime? _lastUpdateTime;
  static const Duration _cacheExpiry = Duration(minutes: 10);

  static Future<Position?> getPosition() async {
    if (_cachedPosition != null && _lastUpdateTime != null) {
      final age = DateTime.now().difference(_lastUpdateTime!);
      if (age < _cacheExpiry) {
        return _cachedPosition;
      }
    }
    
    try {
      final position = await Geolocator.getCurrentPosition();
      _cachedPosition = position;
      _lastUpdateTime = DateTime.now();
      return position;
    } catch (e) {
      TalkerService.instance.error('Error getting location', e);
      return null;
    }
  }

  static void clear() {
    _cachedPosition = null;
    _lastUpdateTime = null;
  }
}

/// Defines interface for event logging implementations
abstract class _EventLogger {
  /// Logs multiple events in a batch
  /// Returns a tuple of (statusCode, message) or null if failed
  Future<(int? statusCode, String? message)?> logEvents(
      List<TrackedActivity> events);
}

/// Types of user activities that can be tracked
enum ActivityType {
  view,    // Content viewing
  react,   // User reactions/likes
  comment, // User comments
  share,   // Content sharing
  system,  // System events
}

/// Priority levels for event processing
enum _EventPriority {
  medium,   // Standard priority, processed in batches
  critical  // High priority, processed immediately
}

// Remove _EventCategory enum completely

/// Model representing a tracked user activity
/// Maps to database table public.tracked_activities
class TrackedActivity {
  // Required fields
  final DateTime activityAt;
  final ActivityType activityType;
  final String userAgentUid;

  // Optional identifying fields
  final String? uid;
  final String? userUid;
  final String? videoPostUid;
  final String? flickPostUid;
  final String? photoPostUid;
  final String? offerUid;
  final String? memoryUid;
  final String? pdfUid;
  final String? commentUid;

  // Metadata fields
  final String? deviceOs;
  final String? deviceModel;
  final String? geoLocationWkb; // Location in WKB format
  final String? appVersion;
  final String? description;
  final _EventPriority priority;

  /// Validates and creates a new activity instance
  TrackedActivity({
    this.uid,
    this.userUid,
    this.videoPostUid,
    this.flickPostUid,
    this.photoPostUid,
    this.offerUid,
    this.memoryUid,
    this.pdfUid,
    required this.activityAt, // Make required
    this.deviceOs,
    this.deviceModel,
    this.geoLocationWkb,
    this.appVersion,
    required this.activityType,
    required this.userAgentUid,
    this.priority = _EventPriority.medium,
    this.description, // Replace metadata with description
    this.commentUid, // Add commentUid parameter
  }) {
    // Validate UUID format for required fields
    assert(userAgentUid.isNotEmpty, 'userAgentUid is required');
  }

  /// Converts activity to JSON format for storage/transmission
  Map<String, dynamic> toJson() => {
        if (uid != null) 'uid': uid,
        if (userUid != null) 'user_uid': userUid,
        if (videoPostUid != null) 'video_post_uid': videoPostUid,
        if (flickPostUid != null) 'flick_post_uid': flickPostUid,
        if (photoPostUid != null) 'photo_post_uid': photoPostUid,
        if (offerUid != null) 'offer_uid': offerUid,
        if (memoryUid != null) 'memory_uid': memoryUid,
        if (pdfUid != null) 'pdf_uid': pdfUid,
        'activity_at': activityAt.toUtc().toIso8601String(),
        if (deviceOs != null) 'device_os': deviceOs,
        if (deviceModel != null) 'device_model': deviceModel,
        if (geoLocationWkb != null) 'geo_location_wkb': geoLocationWkb,
        if (appVersion != null) 'app_version': appVersion,
        'activity_type': activityType.name,
        'user_agent_uid': userAgentUid,
        if (description != null) 'description': description,
        if (commentUid != null) 'comment_uid': commentUid,
        // Remove metadata from toJson
      };

  /// Creates activity instance from JSON data
  factory TrackedActivity.fromJson(Map<String, dynamic> json) {
    return TrackedActivity(
      uid: json['uid'],
      userUid: json['user_uid'],
      videoPostUid: json['video_post_uid'],
      flickPostUid: json['flick_post_uid'],
      photoPostUid: json['photo_post_uid'],
      offerUid: json['offer_uid'],
      memoryUid: json['memory_uid'],
      pdfUid: json['pdf_uid'],
      activityAt: DateTime.parse(json['activity_at']).toLocal(),
      deviceOs: json['device_os'],
      deviceModel: json['device_model'],
      geoLocationWkb:  json['geo_location_wkb'],
      appVersion: json['app_version'],
      activityType: ActivityType.values.firstWhere(
        (e) => e.name == json['activity_type'],
      ),
      userAgentUid: json['user_agent_uid'],
      description: json['description'], // Add description
      commentUid: json['comment_uid'], // Add commentUid
      priority: _EventPriority.medium,
    );
  }
}

/// Persistent storage for activity events using Hive
class _EventStorage {
  late Box<String> _eventBox;

  /// Initializes storage and opens Hive box
  Future<void> initialize() async {
    _eventBox = await Hive.openBox<String>('activity_logs_434325');
  }

  /// Saves single activity event to storage
  Future<void> saveEvent(TrackedActivity event) async {
    final jsonString = jsonEncode(event.toJson());
    await _eventBox.add(jsonString);
  }

  /// Retrieves stored events with optional limit
  Future<List<TrackedActivity>> getEvents({int? limit}) async {
    final events = <TrackedActivity>[];
    final end = limit != null ? min(_eventBox.length, limit) : _eventBox.length;

    for (var i = 0; i < end; i++) {
      final jsonString = _eventBox.getAt(i);
      if (jsonString != null) {
        final json = jsonDecode(jsonString);
        events.add(TrackedActivity.fromJson(json));
      }
    }
    return events;
  }

  /// Removes specified number of oldest events
  Future<void> deleteEvents(int count) async {
    final keys = _eventBox.keys.take(count);
    await _eventBox.deleteAll(keys);
  }

  /// Gets events matching minimum priority level
  Future<List<TrackedActivity>> getPriorityEvents(
      _EventPriority minPriority) async {
    final events = await getEvents();
    return events.where((e) => e.priority.index >= minPriority.index).toList();
  }
}

/// Implementation of event logging using REST API
class _ApiActivityLogger implements _EventLogger {
  @override
  Future<(int? statusCode, String? message)?> logEvents(
      List<TrackedActivity> events) async {
    try {
      // Convert TrackedActivity list to API request model
      final activities = events
          .map((event) => Activity(
                activityAt: event.activityAt,
                userAgentUid: event.userAgentUid,
                userUid: event.userUid,
                activityType: event.activityType.name,
                wtvUid: event.videoPostUid,
                deviceOs: event.deviceOs,
                deviceModel: event.deviceModel,
                appVersion: event.appVersion,
                geoLocation: event.geoLocationWkb, // Just pass the WKB string directly
                flickUid: event.flickPostUid,
                description: event.description,
                photoUid: event.photoPostUid,
                commentUid: event.commentUid, // Use commentUid directly
                memoryUid: event.memoryUid,
              ))
          .toList();

      final request = TrackActivitiesRequest(activities: activities);
      return await TrackedActivityApi.trackActivities(request: request);
    } catch (e) {
      TalkerService.instance.error('API logging error', e);
      rethrow;
    }
  }
}

/// Service for managing activity logging and batch uploads
/// Handles caching, priorities, and batched processing
class ActivityLoggingService {
  final _EventStorage _storage;

  final List<_EventLogger> _loggers;
  Timer? _uploadTimer;
  bool _isUploading = false;

  // Configuration
  final Duration uploadInterval;
  final int batchSize;
  final int _maxBatchSize;
  final StreamController<TrackedActivity> _eventController;

  static ActivityLoggingService? _instance;

  /// Initializes service with given configuration
  /// [loggers]: List of logging implementations to use
  /// [uploadInterval]: How often to process batched events
  /// [batchSize]: Number of events to process per batch
  /// [maxBatchSize]: Maximum events in a single batch
  static Future<ActivityLoggingService> getInstance({
    List<_EventLogger> loggers = const [],
    Duration uploadInterval = const Duration(seconds: 10),
    int batchSize = 10,
    int? maxBatchSize,
  }) async {
    _instance ??= ActivityLoggingService._internal(
      loggers: loggers,
      uploadInterval: uploadInterval,
      batchSize: batchSize,
      maxBatchSize: maxBatchSize,
    );
    return _instance!;
  }

  ActivityLoggingService._internal({
    List<_EventLogger> loggers = const [],
    required this.uploadInterval,
    required this.batchSize,
    int? maxBatchSize,
  })  : _storage = _EventStorage(),
        _loggers = loggers,
        _maxBatchSize = maxBatchSize ?? 15,
        _eventController = StreamController<TrackedActivity>.broadcast();

  Stream<TrackedActivity> get eventStream => _eventController.stream;

  /// Initializes storage and starts upload timer
  Future<void> initialize() async {
    await _storage.initialize();
    await UserAgentInfoService.setDeviceInfo();
    _startUploadTimer();
  }

  void _startUploadTimer() {
    _uploadTimer =
        Timer.periodic(uploadInterval, (_) => _uploadPendingEvents());
  }

  /// Logs a single activity with optional context data
  Future<void> logActivity({
    required ActivityType activityType,
    _EventPriority priority = _EventPriority.medium,
    String? description, // Add description parameter
    String? commentUid, // Add commentUid parameter

    String? videoPostUid,
    String? flickPostUid,
    String? photoPostUid,
    String? offerUid,
    String? memoryUid,
    String? pdfUid,
    bool includeLocation = true,
  }) async {
    try {
      String? userUid = AuthUserDb.getLastLoggedUserUid();
      // Get device info
      final userAgentInfo = UserAgentInfoService.currentDeviceInfo;

      // Get userAgentUid
      final userAgentUid = '5e5abad1-b8eb-4e31-8952-dfcf86e1ecf2';

      // Get location if requested
      String? locationWkb;
      if (includeLocation) {
        final position = await _PositionCache.getPosition();
        if (position != null) {
          locationWkb = WKBUtil.getWkbString(
            lat: position.latitude,
            long: position.longitude,
          );
        }
      }

      final activity = TrackedActivity(
        userUid: userUid,
        videoPostUid: videoPostUid,
        flickPostUid: flickPostUid,
        photoPostUid: photoPostUid,
        offerUid: offerUid,
        memoryUid: memoryUid,
        pdfUid: pdfUid,
        activityAt: DateTime.now(), // Use provided or current time
        deviceOs: userAgentInfo?.deviceOs,
        deviceModel: userAgentInfo?.deviceName,
        geoLocationWkb: locationWkb,
        appVersion: userAgentInfo?.appVersion,
        activityType: activityType,
        userAgentUid: userAgentUid,
        priority: priority,
        description: description, // Use description
        commentUid: commentUid, // Add commentUid
      );

      await _storage.saveEvent(activity);
      _eventController.add(activity);

      // Upload immediately if critical priority
      if (priority == _EventPriority.critical) {
        // Cancel any pending timer to avoid conflicts
        _uploadTimer?.cancel();
        await _uploadPendingEvents(forcePriority: _EventPriority.critical);
        // Restart the timer for regular uploads
        _startUploadTimer();
      }
    } catch (e, stackTrace) {
      TalkerService.instance.handle(e, stackTrace);
      rethrow;
    }
  }

  /// Processes pending events for upload
  Future<void> _uploadPendingEvents({_EventPriority? forcePriority}) async {
    if (_isUploading) return;
    _isUploading = true;

    try {
      // Get events based on priority
      final events = forcePriority != null
          ? await _storage.getPriorityEvents(forcePriority)
          : await _storage.getEvents(
              limit: batchSize); // Use configured batchSize

      if (events.isEmpty) {
        return;
      }

      // Process events in a single batch
      for (final logger in _loggers) {
        final result = await logger.logEvents(events);
        if (result == null || result.$1 == null || result.$1! >= 400) {
          // Log error but don't retry
          TalkerService.instance.error('Upload failed: ${result?.$2}');
          return;
        }
      }

      // Only delete events if upload was successful
      await _storage.deleteEvents(events.length);
    } catch (e) {
      TalkerService.instance.error('Failed to upload events', e);
    } finally {
      _isUploading = false;
    }
  }

  /// Splits events into smaller batches
  List<List<TrackedActivity>> _createBatches(
      List<TrackedActivity> events, int batchSize) {
    return [
      for (var i = 0; i < events.length; i += batchSize)
        events.skip(i).take(batchSize).toList()
    ];
  }

  /// Cleans up resources
  void dispose() {
    _uploadTimer?.cancel();
    _uploadTimer = null;
    _PositionCache.clear(); // Clear position cache on dispose
  }
}

// Make example private or move to separate file
void example546() async {
  final userUid = "MO-ee730066d3464444991ef9610a322d01";

  TalkerService.instance.debug('Starting activity logging example...');

  // Initialize the service with API logger
  final activityLogger = await ActivityLoggingService.getInstance(
    loggers: [_ApiActivityLogger()], // Make sure logger is added
    uploadInterval: Duration(seconds: 5),
    batchSize: 5,
  );

  await activityLogger.initialize();
  TalkerService.instance.debug('Logger initialized');

  // Listen to event stream
  activityLogger.eventStream.listen(
    (activity) {
      TalkerService.instance
          .log('Activity logged successfully: ${activity.activityType}');
    },
    onError: (error) {
      TalkerService.instance.error('Activity logging error', error);
    },
  );

  try {
    TalkerService.instance.debug('Logging system activity...');
    await activityLogger.logActivity(
      activityType: ActivityType.system,
      description: 'Registered as @johndoe',
    );
    TalkerService.instance.debug('Logging video view...');
    await activityLogger.logActivity(
      activityType: ActivityType.view,
      videoPostUid: '008f735f-6033-4e05-a123-e34f628851fc',
    );

    await Future.delayed(Duration(seconds: 2)); // Add delay between logs

    TalkerService.instance.debug('Logging flick reaction...');
    await activityLogger.logActivity(
      activityType: ActivityType.react,
      flickPostUid: '00327731-e8f9-4f33-b700-29b16798a65a',
      
    );

    await Future.delayed(Duration(seconds: 2));

    await activityLogger.logActivity(
      activityType: ActivityType.comment,
      memoryUid: '0039635d-7b69-4a53-a37e-018833d12c53',
     
      commentUid: '255b707f-2b01-4d23-8836-503107a9647f',
    );

    await Future.delayed(Duration(seconds: 2));

    // Add share activity
    TalkerService.instance.debug('Logging photo share...');
    await activityLogger.logActivity(
      activityType: ActivityType.share,
      photoPostUid: '00518fee-3c8a-4eec-b184-75e79b39f62c',
      description: 'A share', // Device info as description
    );
  } catch (e, stackTrace) {
    TalkerService.instance.handle(e, stackTrace);
  } finally {
    // Delay disposal to allow events to be processed
    await Future.delayed(Duration(seconds: 5));
    activityLogger.dispose();
    TalkerService.instance.debug('Logger disposed');
  }
}
