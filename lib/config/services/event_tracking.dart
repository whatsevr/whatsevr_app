import 'dart:convert';
import 'dart:math';
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:whatsevr_app/config/api/methods/tracked_activities.dart';
import 'package:whatsevr_app/config/api/requests_model/tracked_activity/track_activities.dart';

import 'package:whatsevr_app/config/services/user_agent_info.dart';
import 'package:whatsevr_app/dev/talker.dart';

// Make logger interface private since it's internal
/// Event logging abstraction for tracking user activities
abstract class _EventLogger {
  /// Logs multiple events in a batch
  /// Returns a tuple of (statusCode, message) or null if failed
  Future<(int? statusCode, String? message)?> logEvents(List<TrackedActivity> events);
}

// Public enums used in API
enum ActivityType {
  view,
  like,
  comment,
  share,

}

// Make internal enums private
enum _EventPriority {
  low,
  medium,
  high,
  critical
}

enum _EventCategory {
  interaction,
  navigation,
  media,
  error,
  performance,
  security
}

// Model matching public.tracked_activities table
/// Represents a tracked user activity with associated metadata
class TrackedActivity {
  final String? uid; // UUID
  final String? userUid;
  final String? videoPostUid; // UUID
  final String? flickPostUid; // UUID
  final String? photoPostUid; // UUID
  final String? offerUid; // UUID
  final String? memoryUid; // UUID
  final String? pdfUid; // UUID
  final DateTime activityAt;
  final String? deviceOs;
  final String? deviceModel;
  final Position? geoLocation;
  final String? appVersion;
  final ActivityType activityType;
  final String userAgentUid; // UUID, not null
  final _EventPriority priority; // For client-side prioritization
  final _EventCategory category; // For client-side categorization
  final Map<String, dynamic>? metadata; // For client-side use

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
    DateTime? activityAt,
    this.deviceOs,
    this.deviceModel,
    this.geoLocation,
    this.appVersion,
    required this.activityType,
    required this.userAgentUid,
    this.priority = _EventPriority.medium,
    this.category = _EventCategory.interaction,
    this.metadata,
  }) : activityAt = activityAt ?? DateTime.now() {
    // Validate UUID format for required fields
    assert(userAgentUid.isNotEmpty, 'userAgentUid is required');
    assert(_isValidUuid(userAgentUid), 'Invalid UUID format for userAgentUid');
    // Validate optional UUIDs if provided
    if (videoPostUid != null) assert(_isValidUuid(videoPostUid!));
    if (flickPostUid != null) assert(_isValidUuid(flickPostUid!));
    if (photoPostUid != null) assert(_isValidUuid(photoPostUid!));
    if (offerUid != null) assert(_isValidUuid(offerUid!));
    if (memoryUid != null) assert(_isValidUuid(memoryUid!));
    if (pdfUid != null) assert(_isValidUuid(pdfUid!));
  }

  /// Validates UUID format using regex
  static bool _isValidUuid(String uuid) {
    final RegExp uuidRegExp = RegExp(
      r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$',
      caseSensitive: false,
    );
    return uuidRegExp.hasMatch(uuid);
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
    if (geoLocation != null) 'geo_location': {
      'type': 'Point',
      'coordinates': [geoLocation!.longitude, geoLocation!.latitude]
    },
    if (appVersion != null) 'app_version': appVersion,
    'activity_type': activityType.name,
    'user_agent_uid': userAgentUid,
  };

  /// Creates activity instance from JSON data
  factory TrackedActivity.fromJson(Map<String, dynamic> json) {
    Position? geoLocation;
    if (json['geo_location'] != null) {
      final coords = json['geo_location']['coordinates'] as List;
      geoLocation = Position(
        longitude: coords[0],
        latitude: coords[1],
        timestamp: DateTime.now(),
        accuracy: 0,
        altitude: 0,
        altitudeAccuracy: 0,
        heading: 0,
        headingAccuracy: 0,
        speed: 0,
        speedAccuracy: 0,
      );
    }

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
      geoLocation: geoLocation,
      appVersion: json['app_version'],
      activityType: ActivityType.values.firstWhere(
        (e) => e.name == json['activity_type'],
      ),
      userAgentUid: json['user_agent_uid'],
      // Client-side only fields
      priority: _EventPriority.medium,
      category: _EventCategory.interaction,
    );
  }
}

// Make storage implementation private
/// Handles persistent storage of activity events
class _EventStorage {
  late Box<String> _eventBox;
  
  /// Initializes storage and opens Hive box
  Future<void> initialize() async {
    _eventBox = await Hive.openBox<String>('activity_logs');
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
  Future<List<TrackedActivity>> getPriorityEvents(_EventPriority minPriority) async {
    final events = await getEvents();
    return events.where((e) => e.priority.index >= minPriority.index).toList();
  }
}

// Make logger implementation private
/// REST API implementation of event logging using TrackedActivityApi
class _ApiActivityLogger implements _EventLogger {
  @override
  Future<(int? statusCode, String? message)?> logEvents(List<TrackedActivity> events) async {
    try {
      // Convert TrackedActivity list to API request model
      final activities = events.map((event) => Activity(
        userAgentUid: event.userAgentUid,
        userUid: event.userUid,
        activityType: event.activityType.name,
        wtvUid: event.videoPostUid,
        deviceOs: event.deviceOs,
        deviceModel: event.deviceModel,
        appVersion: event.appVersion,
        geoLocation: event.geoLocation != null 
          ? '${event.geoLocation!.latitude},${event.geoLocation!.longitude}'
          : null,
        flickUid: event.flickPostUid,
        description: event.metadata?['description'],
        photoUid: event.photoPostUid,
        commentUid: event.metadata?['commentUid'],
        memoryUid: event.memoryUid,
      )).toList();

      final request = TrackActivitiesRequest(activities: activities);
      return await TrackedActivityApi.trackActivities(request: request);
      
    } catch (e) {
      TalkerService.instance.error('API logging error', e);
      rethrow;
    }
  }
}

// Public service class
/// Main service for managing activity logging and batch uploads
class ActivityLoggingService {
  final _EventStorage _storage;
  final String _userAgentUid;
  final List<_EventLogger> _loggers;
  Timer? _uploadTimer;
  bool _isUploading = false;
  
  // Configuration
  final Duration uploadInterval;
  final int batchSize;
  final int _maxBatchSize;
  final StreamController<TrackedActivity> _eventController;
  
  static ActivityLoggingService? _instance;
  
  /// Gets singleton instance with optional configuration
  static Future<ActivityLoggingService> getInstance({
    required String userAgentUid,
    List<_EventLogger> loggers = const [],
    Duration uploadInterval = const Duration(minutes: 5),
    int batchSize = 50,
    int? maxBatchSize,
  }) async {
    _instance ??= ActivityLoggingService._internal(
      userAgentUid: userAgentUid,
      loggers: loggers,
      uploadInterval: uploadInterval,
      batchSize: batchSize,
      maxBatchSize: maxBatchSize,
    );
    return _instance!;
  }
  
  ActivityLoggingService._internal({
    required String userAgentUid,
    List<_EventLogger> loggers = const [],
    required this.uploadInterval,
    required this.batchSize,
    int? maxBatchSize,
  }) : _storage = _EventStorage(),
       _userAgentUid = userAgentUid,
       _loggers = loggers,
       _maxBatchSize = maxBatchSize ?? 100,
       _eventController = StreamController<TrackedActivity>.broadcast();

  Stream<TrackedActivity> get eventStream => _eventController.stream;

  /// Initializes storage and starts upload timer
  Future<void> initialize() async {
    await _storage.initialize();
    await UserAgentInfoService.setDeviceInfo();
    _startUploadTimer();
  }

  void _startUploadTimer() {
    _uploadTimer = Timer.periodic(uploadInterval, (_) => _uploadPendingEvents());
  }

  /// Logs a single activity with optional context data
  Future<void> logActivity({
    required ActivityType activityType,
    required _EventCategory category,
    _EventPriority priority = _EventPriority.medium,
    Map<String, dynamic>? metadata,
    String? userUid,
    String? videoPostUid,
    String? flickPostUid,
    String? photoPostUid,
    String? offerUid,
    String? memoryUid,
    String? pdfUid,
    bool includeLocation = false,
  }) async {
    try {
      // Get device info
      final userAgentInfo = UserAgentInfoService.currentDeviceInfo;
     

   
      
      // Get location if requested
      Position? location;
      if (includeLocation) {
        try {
          location = await Geolocator.getCurrentPosition();
        } catch (e) {
          TalkerService.instance.error('Error getting location', e);
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
        deviceOs: userAgentInfo?.deviceOs,
        deviceModel: userAgentInfo?.deviceName,
        geoLocation: location,
        appVersion: userAgentInfo?.appVersion,
        activityType: activityType,
        userAgentUid: _userAgentUid,
        
        priority: priority,
        category: category,
        metadata: metadata,
      );
      
      await _storage.saveEvent(activity);
      _eventController.add(activity);

      // Upload immediately if high priority
      if (priority == _EventPriority.critical) {
        await _uploadPendingEvents(forcePriority: priority);
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
      final events = forcePriority != null
          ? await _storage.getPriorityEvents(forcePriority)
          : await _storage.getEvents(limit: _maxBatchSize);

      if (events.isEmpty) {
        return;
      }

      final batches = _createBatches(events, _maxBatchSize);
      for (final batch in batches) {
        for (final logger in _loggers) {
          final result = await logger.logEvents(batch);
          if (result == null || result.$1 == null || result.$1! >= 400) {
            throw Exception('Failed to upload events: ${result?.$2}');
          }
        }
      }
      
      await _storage.deleteEvents(events.length);

    } catch (e) {
      TalkerService.instance.error('Failed to upload events', e);
      rethrow;
    } finally {
      _isUploading = false;
    }
  }

  /// Splits events into smaller batches
  List<List<TrackedActivity>> _createBatches(List<TrackedActivity> events, int batchSize) {
    return [
      for (var i = 0; i < events.length; i += batchSize)
        events.skip(i).take(batchSize).toList()
    ];
  }
  
  /// Cleans up resources
  void dispose() {
    _uploadTimer?.cancel();
    _uploadTimer = null;
  }
}

// Make example private or move to separate file
void _example() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  
  // Initialize the service
  final activityLogger = await ActivityLoggingService.getInstance(
    userAgentUid: 'your-user-agent-uid',
    uploadInterval: Duration(minutes: 15),
    batchSize: 100,
  );
  
  await activityLogger.initialize();
  
  // Log a video view activity
  try {
    await activityLogger.logActivity(
      activityType: ActivityType.view,
      category: _EventCategory.media,
      userUid: 'current-user-uid',
      videoPostUid: 'video-123',
      includeLocation: true,
    );
  } catch (e, stackTrace) {
    TalkerService.instance.handle(e, stackTrace);
  }
}