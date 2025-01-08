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
import 'package:firebase_analytics/firebase_analytics.dart';

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
  bool _hasUnuploadedLogs = false; // Track if logs are pending

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
    if (_instance == null) {
      _instance = ActivityLoggingService._internal(
        loggers: loggers,
        uploadInterval: uploadInterval,
        batchSize: batchSize,
        maxBatchSize: maxBatchSize,
      );
      // Initialize immediately after creation
      await _instance!.initialize();
    }
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
    _uploadTimer?.cancel();
    _uploadTimer = Timer.periodic(uploadInterval, (_) => _uploadPendingEvents());
  }

  /// Static method to log activity without creating instance
  static Future<void> log({
    required ActivityType activityType,
    bool uploadToDb = true,
    bool uploadToFirebase = false,
    _EventPriority priority = _EventPriority.medium,
    String? description,
    String? commentUid,
    String? videoPostUid,
    String? flickPostUid,
    String? photoPostUid,
    String? offerUid,
    String? memoryUid,
    String? pdfUid,
    bool includeLocation = true,
  }) async {
    // Get instance and ensure it's initialized
    final instance = await getInstance(
      loggers: [
        if (uploadToDb) _ApiActivityLogger(),
        if (uploadToFirebase) _FirebaseAnalyticsLogger(),
      ],
    );
    
    // No need to call initialize() here since getInstance handles it
    await instance.logActivity(
      activityType: activityType,
      priority: priority,
      description: description,
      commentUid: commentUid,
      videoPostUid: videoPostUid,
      flickPostUid: flickPostUid,
      photoPostUid: photoPostUid,
      offerUid: offerUid,
      memoryUid: memoryUid,
      pdfUid: pdfUid,
      includeLocation: includeLocation,
    );
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
      _hasUnuploadedLogs = true; // Mark that we have pending logs
      _eventController.add(activity);

      if (!(_uploadTimer?.isActive ?? true)) {
        _startUploadTimer(); // Restart timer if stopped
      }

      // Upload immediately if critical priority
      if (priority == _EventPriority.critical) {
        // Cancel any pending timer to avoid conflicts
        _uploadTimer?.cancel();
        await _uploadPendingEvents(forcePriority: _EventPriority.critical);
        if (_hasUnuploadedLogs) {
          _startUploadTimer();
        }
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
        _hasUnuploadedLogs = false;
        _uploadTimer?.cancel(); // Stop timer when no more logs
        _uploadTimer = null;
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
      
      // Check if more events exist
      final remaining = await _storage.getEvents();
      _hasUnuploadedLogs = remaining.isNotEmpty;
      
      if (!_hasUnuploadedLogs) {
        _uploadTimer?.cancel();
        _uploadTimer = null;
      }
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
  Future<void> dispose() async {
    // Try to upload any remaining logs before disposing
    if (_hasUnuploadedLogs && !_isUploading) {
      await _uploadPendingEvents();
    }
    
    _uploadTimer?.cancel();
    _uploadTimer = null;
    _PositionCache.clear();
    await _eventController.close();
    _instance = null; // Reset singleton instance
  }
}

// Add this class for Firebase Analytics logging
class _FirebaseAnalyticsLogger implements _EventLogger {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  /// Converts activity type to Firebase event name
  String _getEventName(ActivityType type) {
    switch (type) {
      case ActivityType.view:
        return 'content_view';
      case ActivityType.react:
        return 'user_reaction';
      case ActivityType.comment:
        return 'user_comment';
      case ActivityType.share:
        return 'content_share';
      case ActivityType.system:
        return 'system_event';
    }
  }

  @override
  Future<(int? statusCode, String? message)?> logEvents(
      List<TrackedActivity> events) async {
    try {
      for (final event in events) {
        // Base parameters that are common for all events
        final params = <String, dynamic>{
          'event_timestamp': event.activityAt.millisecondsSinceEpoch,
          'event_time_local': event.activityAt.toLocal().toString(),
          'activity_type': event.activityType.name,
          
          // User context
          if (event.userUid != null) 'user_id': event.userUid,
          
          // Device context
          if (event.deviceOs != null) ..._cleanDeviceParams({
            'device_os': event.deviceOs,
            'device_model': event.deviceModel,
            'app_version': event.appVersion,
          }),
          
          // Location context
          'has_location': (event.geoLocationWkb != null).toString(),
          
          // Event metadata
          if (event.description != null) 'event_description': event.description,
          'event_priority': event.priority.name,
        };

        // Add content-specific parameters
        String? contentType;
        String? contentId;
        
        if (event.videoPostUid != null) {
          contentType = 'video';
          contentId = event.videoPostUid;
        } else if (event.flickPostUid != null) {
          contentType = 'flick';
          contentId = event.flickPostUid;
        } else if (event.photoPostUid != null) {
          contentType = 'photo';
          contentId = event.photoPostUid;
        } else if (event.memoryUid != null) {
          contentType = 'memory';
          contentId = event.memoryUid;
        } else if (event.pdfUid != null) {
          contentType = 'pdf';
          contentId = event.pdfUid;
        }

        if (contentType != null) {
          params.addAll({
            'content_type': contentType,
            'content_id': contentId!,
          });
        }

        // Add interaction-specific parameters
        if (event.commentUid != null) {
          params['interaction_type'] = 'comment';
          params['comment_id'] = event.commentUid;
        }

        // Log the enhanced event
        final eventName = _getEventName(event.activityType);
        await _analytics.logEvent(
          name: eventName,
          parameters: params.cast<String, Object>(),
        );

        // Set user properties for better tracking
        if (event.userUid != null) {
          await _setUserProperties(event);
        }
      }
      return (200, 'Events logged to Firebase Analytics');
    } catch (e) {
      TalkerService.instance.error('Firebase Analytics error', e);
      return (500, e.toString());
    }
  }

  /// Clean device parameters by removing null values and invalid characters
  Map<String, String> _cleanDeviceParams(Map<String?, String?> params) {
    return Map.fromEntries(
      params.entries
        .where((e) => e.value != null)
        .map((e) => MapEntry(e.key!, e.value!.replaceAll(RegExp(r'[^\w\s.-]'), ''))),
    );
  }

  /// Set user properties for better user segmentation
  Future<void> _setUserProperties(TrackedActivity event) async {
    if (event.userUid != null) {
      await _analytics.setUserId(id: event.userUid);
      
      // Set user device properties
      if (event.deviceOs != null) {
        await _analytics.setUserProperty(
          name: 'user_device_os',
          value: event.deviceOs,
        );
      }
      if (event.deviceModel != null) {
        await _analytics.setUserProperty(
          name: 'user_device_model',
          value: event.deviceModel,
        );
      }
      if (event.appVersion != null) {
        await _analytics.setUserProperty(
          name: 'app_version',
          value: event.appVersion,
        );
      }
      
      // Set user engagement properties
      await _analytics.setUserProperty(
        name: 'last_activity_type',
        value: event.activityType.name,
      );
      
      // Set content preference based on most recent interaction
      if (event.videoPostUid != null || 
          event.flickPostUid != null ||
          event.photoPostUid != null ||
          event.memoryUid != null ||
          event.pdfUid != null) {
        await _analytics.setUserProperty(
          name: 'preferred_content_type',
          value: _determineContentType(event),
        );
      }
    }
  }

  /// Determine the content type from the event
  String _determineContentType(TrackedActivity event) {
    if (event.videoPostUid != null) return 'video';
    if (event.flickPostUid != null) return 'flick';
    if (event.photoPostUid != null) return 'photo';
    if (event.memoryUid != null) return 'memory';
    if (event.pdfUid != null) return 'pdf';
    return 'unknown';
  }
}

// Make example private or move to separate file
void example546() async {
  TalkerService.instance.debug('Starting activity logging example...');

  try {
    // System activity with both DB and Firebase logging
    await ActivityLoggingService.log(
      activityType: ActivityType.system,
      description: 'Registered as @johndoe',
      uploadToDb: true,
      uploadToFirebase: true,
    );

    // Video view with only DB logging (default)
    await ActivityLoggingService.log(
      activityType: ActivityType.view,
      videoPostUid: '008f735f-6033-4e05-a123-e34f628851fc',
    );

    await Future.delayed(Duration(seconds: 2));

    // Flick reaction with only Firebase Analytics
    await ActivityLoggingService.log(
      activityType: ActivityType.react,
      flickPostUid: '00327731-e8f9-4f33-b700-29b16798a65a',
      uploadToDb: false,
      uploadToFirebase: true,
    );

    await Future.delayed(Duration(seconds: 2));

    // Comment with both logging destinations
    await ActivityLoggingService.log(
      activityType: ActivityType.comment,
      memoryUid: '0039635d-7b69-4a53-a37e-018833d12c53',
      commentUid: '255b707f-2b01-4d23-8836-503107a9647f',
      uploadToDb: true,
      uploadToFirebase: true,
    );

    await Future.delayed(Duration(seconds: 2));

    // Share with only DB logging
    await ActivityLoggingService.log(
      activityType: ActivityType.share,
      photoPostUid: '00518fee-3c8a-4eec-b184-75e79b39f62c',
      description: 'A share',
    );

  } catch (e, stackTrace) {
    TalkerService.instance.handle(e, stackTrace);
  }
}


