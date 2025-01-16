import 'dart:convert';
import 'dart:math';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/api/methods/tracked_activities.dart';
import 'package:whatsevr_app/config/api/requests_model/tracked_activity/track_activities.dart';
import 'package:whatsevr_app/config/enums/activity_type.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';

import 'package:whatsevr_app/config/services/user_agent_info.dart';
import 'package:whatsevr_app/dev/talker.dart';
import 'package:whatsevr_app/utils/geopoint_wkb_parser.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:easy_debounce/easy_debounce.dart';

// Make priority enum private
enum Priority {
  normal,
  critical,
}

// Make TrackedActivity class private since it's only used internally
class _TrackedActivity {
  // Required fields
  final DateTime activityAt;
  final WhatsevrActivityType activityType;

  // Optional identifying fields
  final String? uid;
  final String? userUid;
  final String? wtvUid;
  final String? flickPostUid;
  final String? photoPostUid;
  final String? offerUid;
  final String? memoryUid;
  final String? pdfUid;
  final String? commentUid;
  final String? commentReplyUid; // Renamed from replyUid

  // Metadata fields
  final String? deviceOs;
  final String? deviceModel;
  final String? geoLocationWkb; // Location in WKB format
  final String? appVersion;
  final Map<String, dynamic>? metadata;
  final Priority priority;

  /// Validates and creates a new activity instance
  _TrackedActivity({
    this.uid,
    this.userUid,
    this.wtvUid,
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
    this.priority = Priority.normal,
    this.metadata, // Replace metadata with description
    this.commentUid, // Add commentUid parameter
    this.commentReplyUid, // Renamed from replyUid
  }) {
    // Validate that metadata is proper JSON-serializable
    if (metadata != null) {
      try {
        // Test JSON serialization to ensure it's valid JSONB
        json.encode(metadata);
      } catch (e) {
        throw ArgumentError('metadata must be JSON-serializable');
      }
    }
  }

  /// Converts activity to JSON format for storage/transmission
  Map<String, dynamic> toJson() => {
        if (uid != null) 'uid': uid,
        if (userUid != null) 'user_uid': userUid,
        if (wtvUid != null) 'wtv_uid': wtvUid,
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

        if (metadata != null) 'metadata': metadata, // Will be stored as JSONB
        if (commentUid != null) 'comment_uid': commentUid,
        if (commentReplyUid != null)
          'comment_reply_uid': commentReplyUid, // Update key name too
        'priority': priority.name, // Add priority to JSON
        // Remove metadata from toJson
      };

  /// Creates activity instance from JSON data
  factory _TrackedActivity.fromJson(Map<String, dynamic> json) {
    return _TrackedActivity(
      uid: json['uid'],
      userUid: json['user_uid'],
      wtvUid: json['wtv_uid'],
      flickPostUid: json['flick_post_uid'],
      photoPostUid: json['photo_post_uid'],
      offerUid: json['offer_uid'],
      memoryUid: json['memory_uid'],
      pdfUid: json['pdf_uid'],
      activityAt: DateTime.parse(json['activity_at']).toLocal(),
      deviceOs: json['device_os'],
      deviceModel: json['device_model'],
      geoLocationWkb: json['geo_location_wkb'],
      appVersion: json['app_version'],
      activityType: WhatsevrActivityType.values.firstWhere(
        (e) => e.name == json['activity_type'],
      ),

      metadata: json['metadata'] != null
          ? Map<String, dynamic>.from(json['metadata'])
          : null,
      commentUid: json['comment_uid'], // Add commentUid
      commentReplyUid: json['comment_reply_uid'], // Updated key name
      priority: json['priority'] != null
          ? Priority.values.firstWhere(
              (e) => e.name == json['priority'],
              orElse: () => Priority.normal,
            )
          : Priority.normal,
    );
  }
}

/// Public API for activity logging service
class ActivityLoggingService {
  // Keep the public static log method as the main API
  static Future<void> log({
    required WhatsevrActivityType activityType,
    String? userUid,
    Priority priority = Priority.normal, // Add priority parameter
    bool uploadToDb = true,
    bool uploadToFirebase = false,
    Map<String, dynamic>? metadata,
    String? commentUid,
    String? commentReplyUid, // Renamed parameter
    String? wtvUid,
    String? flickPostUid,
    String? photoPostUid,
    String? offerUid,
    String? memoryUid,
    String? pdfUid,
    bool includeLocation = true,
  }) async {
    try {
      TalkerService.instance.debug(
          'Activity log request: type=$activityType, priority=$priority, '
          'uploadToDb=$uploadToDb, uploadToFirebase=$uploadToFirebase');

      final instance = await getInstance(
        loggers: [
          if (uploadToDb) _ApiActivityLogger(),
          if (uploadToFirebase) _FirebaseAnalyticsLogger(),
        ],
      );

      await instance?._logActivity(
        userUid: userUid,
        activityType: activityType,
        priority: priority, // Pass the priority parameter
        metadata: metadata,
        commentUid: commentUid,
        commentReplyUid: commentReplyUid, // Renamed argument
        wtvUid: wtvUid,
        flickPostUid: flickPostUid,
        photoPostUid: photoPostUid,
        offerUid: offerUid,
        memoryUid: memoryUid,
        pdfUid: pdfUid,
        includeLocation: includeLocation,
      );
    } catch (e, stackTrace) {
      lowLevelCatch(e, stackTrace);
    }
  }

  // Make everything else private
  static ActivityLoggingService? _instance;
  final _EventStorage _storage;
  final List<_EventLogger> _loggers;
  bool _isUploading = false;
  bool _hasUnuploadedLogs = false;

  final StreamController<_TrackedActivity> _eventController;

  static const _uploadDebounceKey = 'activity_upload_debouncer';
  static const _defaultDebounceTime = Duration(seconds: 5);

  // Make constructor private
  ActivityLoggingService._internal({
    required List<_EventLogger> loggers,
    required int batchSize,
  })  : _storage = _EventStorage(),
        _loggers = loggers, 
       
        _eventController = StreamController<_TrackedActivity>.broadcast();

  Stream<_TrackedActivity> get eventStream => _eventController.stream;

  /// Initializes storage and starts upload timer
  Future<void> initialize() async {
    try {
      EasyDebounce.cancel(_uploadDebounceKey);
      await _storage.initialize();
      await UserAgentInfoService.setDeviceInfo();
    } catch (e, stackTrace) {
      lowLevelCatch(e, stackTrace);
    }
  }

  /// Static method to log activity without creating instance
  static Future<ActivityLoggingService?> getInstance({
    List<_EventLogger> loggers = const [],
    Duration uploadInterval = const Duration(seconds: 10),
    int batchSize = 10,
    int? maxBatchSize,
  }) async {
    try {
      if (_instance == null) {
        _instance = ActivityLoggingService._internal(
          loggers: loggers,
          batchSize: batchSize,
         
        );
        // Initialize immediately after creation and handle errors
        await _instance!.initialize().catchError((e, stack) {
          TalkerService.instance.handle(e, stack);
          _instance = null; // Reset instance if initialization fails
          throw e; // Re-throw to notify caller
        });
      } else if (loggers.isNotEmpty) {
        // Update loggers if provided
        _instance!._loggers.clear();
        _instance!._loggers.addAll(loggers);
      }
      return _instance!;
    } catch (e, stackTrace) {
      lowLevelCatch(e, stackTrace);
    }
    return null;
  }

  /// Logs a single activity with optional context data
  Future<void> _logActivity({
    required WhatsevrActivityType activityType,
    String? userUid,
    Priority priority = Priority.normal,
    Map<String, dynamic>? metadata,
    String? commentUid, // Add commentUid parameter
    String? commentReplyUid, // Renamed parameter

    String? wtvUid,
    String? flickPostUid,
    String? photoPostUid,
    String? offerUid,
    String? memoryUid,
    String? pdfUid,
    bool includeLocation = true,
  }) async {
    try {
      userUid ??= AuthUserDb.getLastLoggedUserUid();
      // Get device info
      final userAgentInfo = UserAgentInfoService.currentDeviceInfo;

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

      final activity = _TrackedActivity(
        userUid: userUid,
        wtvUid: wtvUid,
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
        priority: priority,
        metadata: metadata, // Use description
        commentUid: commentUid, // Add commentUid
        commentReplyUid: commentReplyUid, // Renamed argument
      );

      TalkerService.instance.debug('Saving activity to storage');
      await _storage.saveEvent(activity); // Make sure this is awaited
      _hasUnuploadedLogs = true;
      _eventController.add(activity);

      TalkerService.instance
          .debug('Activity saved, has unuploaded logs: $_hasUnuploadedLogs');

      // Replace timer-based upload with debounced upload
      if (priority == Priority.critical) {
        // Cancel any pending debounced upload
        EasyDebounce.cancel(_uploadDebounceKey);
        await _uploadPendingEvents(forcePriority: Priority.critical);
      } else {
        // Schedule debounced upload for normal priority events
        EasyDebounce.debounce(
          _uploadDebounceKey,
          _defaultDebounceTime,
          () => _uploadPendingEvents(),
        );
      }
    } catch (e, stackTrace) {
      lowLevelCatch(e, stackTrace);
    }
  }

  /// Processes pending events for upload
  Future<void> _uploadPendingEvents({Priority? forcePriority}) async {
    if (_isUploading) {
      TalkerService.instance.debug('Upload already in progress, skipping');
      return;
    }

    _isUploading = true;

    try {
      TalkerService.instance.debug('Starting event upload');

      if (!_storage._eventBox.isOpen) {
        await _storage.initialize();
      }

      // Get ALL events of specified priority or normal priority
      List<_TrackedActivity> events;
      if (forcePriority != null) {
        events = await _storage.getPriorityEvents(forcePriority);
      } else {
        // For normal upload, get ALL normal priority events including any new ones
        events = await _storage.getPriorityEvents(Priority.normal);
      }

      TalkerService.instance.debug('Found ${events.length} events to upload');

      if (events.isEmpty) {
        _hasUnuploadedLogs = false;
        return;
      }

      // Upload all events in a single batch
      bool uploadSuccess = true;
      for (final logger in _loggers) {
        final result = await logger.logEvents(events);
        if (result == null || result.$1 == null || result.$1! >= 400) {
          uploadSuccess = false;
          TalkerService.instance.error(
              'Upload failed for logger ${logger.runtimeType}: ${result?.$2}',);
          break;
        }
      }

      // Only delete events if upload was successful
      if (uploadSuccess) {
        await _storage.deleteEvents(events.length);
        TalkerService.instance
            .debug('Successfully uploaded and deleted ${events.length} events');

        // Check for any remaining events
        final remaining = await _storage.getEvents();
        _hasUnuploadedLogs = remaining.isNotEmpty;

        // If no more events, cancel any pending debouncer
        if (!_hasUnuploadedLogs) {
          EasyDebounce.cancel(_uploadDebounceKey);
        }
      }
    } catch (e, stackTrace) {
      TalkerService.instance.error('Error during event upload', e, stackTrace);
    } finally {
      _isUploading = false;
    }
  }

  /// Splits events into smaller batches
  List<List<_TrackedActivity>> _createBatches(
      List<_TrackedActivity> events, int batchSize,) {
    return [
      for (var i = 0; i < events.length; i += batchSize)
        events.skip(i).take(batchSize).toList(),
    ];
  }

  /// Cleans up resources
  Future<void> dispose() async {
    try {
      EasyDebounce.cancel(_uploadDebounceKey);

      // Upload any remaining logs before disposing
      if (_hasUnuploadedLogs && !_isUploading) {
        await _uploadPendingEvents();
      }

      _PositionCache.clear();
      await _eventController.close();
      _instance = null;
    } catch (e, stackTrace) {
      lowLevelCatch(e, stackTrace);
    }
  }
}

// Rest of the helper classes should be private
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
    } catch (e, stackTrace) {
      lowLevelCatch(e, stackTrace);
      return null;
    }
  }

  static void clear() {
    _cachedPosition = null;
    _lastUpdateTime = null;
  }
}

abstract class _EventLogger {
  /// Logs multiple events in a batch
  /// Returns a tuple of (statusCode, message) or null if failed
  Future<(int? statusCode, String? message)?> logEvents(
      List<_TrackedActivity> events,);
}

class _EventStorage {
  late Box<String> _eventBox;
  static const String boxName = 'activity_logs_868';

  Future<void> initialize() async {
    try {
      if (!Hive.isBoxOpen(boxName)) {
        _eventBox = await Hive.openBox<String>(boxName);
        TalkerService.instance.debug('Initialized Hive box: $boxName');
      } else {
        _eventBox = Hive.box<String>(boxName);
        TalkerService.instance.debug('Reused existing Hive box: $boxName');
      }
      TalkerService.instance.debug('Current box length: ${_eventBox.length}');
    } catch (e, stack) {
      TalkerService.instance.error('Hive initialization failed', e, stack);
      rethrow;
    }
  }

  Future<void> saveEvent(_TrackedActivity event) async {
    try {
      if (!_eventBox.isOpen) {
        await initialize();
      }
      final jsonString = jsonEncode(event.toJson());
      await _eventBox.add(jsonString);
      TalkerService.instance.debug(
          'Saved event to storage. Box values: ${_eventBox.values.length}',);
    } catch (e, stack) {
      TalkerService.instance.error('Failed to save event', e, stack);
      rethrow;
    }
  }

  Future<List<_TrackedActivity>> getEvents({int? limit}) async {
    try {
      if (!_eventBox.isOpen) {
        await initialize();
      }

      final events = <_TrackedActivity>[];
      final values = _eventBox.values.toList();
      TalkerService.instance
          .debug('Getting events. Total in box: ${values.length}');

      final end = limit != null ? min(values.length, limit) : values.length;

      for (var i = 0; i < end; i++) {
        try {
          final json = jsonDecode(values[i]);
          events.add(_TrackedActivity.fromJson(json));
        } catch (e) {
          TalkerService.instance.error('Failed to parse event at index $i', e);
          continue;
        }
      }

      TalkerService.instance.debug('Retrieved ${events.length} events');
      return events;
    } catch (e, stack) {
      TalkerService.instance.error('Error getting events', e, stack);
      return [];
    }
  }

  Future<void> deleteEvents(int count) async {
    try {
      if (!_eventBox.isOpen) {
        await initialize();
      }

      final keys = _eventBox.keys.take(count).toList();
      TalkerService.instance.debug('Deleting ${keys.length} events');
      await _eventBox.deleteAll(keys);
      TalkerService.instance
          .debug('After deletion, remaining events: ${_eventBox.length}');
    } catch (e, stack) {
      TalkerService.instance.error('Failed to delete events', e, stack);
      rethrow;
    }
  }

  /// Gets events matching minimum priority level
  Future<List<_TrackedActivity>> getPriorityEvents(Priority minPriority) async {
    try {
      final events = await getEvents();
      TalkerService.instance.debug(
          'Filtering ${events.length} events for priority >= ${minPriority.name}',);

      final filteredEvents = events.where((e) {
        final meets = e.priority.index >= minPriority.index;
        TalkerService.instance.debug(
            'Event priority ${e.priority.name} ${meets ? "meets" : "does not meet"} minimum ${minPriority.name}',);
        return meets;
      }).toList();

      TalkerService.instance.debug(
          'Found ${filteredEvents.length} events matching priority ${minPriority.name}',);
      return filteredEvents;
    } catch (e, stack) {
      TalkerService.instance.error('Error filtering priority events', e, stack);
      return [];
    }
  }
}

class _ApiActivityLogger implements _EventLogger {
  @override
  Future<(int? statusCode, String? message)?> logEvents(
      List<_TrackedActivity> events,) async {
    try {
      TalkerService.instance
          .debug('Attempting to log ${events.length} events to API');

      final activities = events
          .map((event) => Activity(
                userUid: event.userUid,
                activityType: event.activityType.name,
                deviceOs: event.deviceOs,
                deviceModel: event.deviceModel,
                appVersion: event.appVersion,
                geoLocation: event.geoLocationWkb,
                activityAt: event.activityAt, // Pass DateTime directly
                wtvUid: event.wtvUid,
                flickUid: event.flickPostUid,
                photoUid: event.photoPostUid,
                commentUid: event.commentUid,
                commentReplyUid: event.commentReplyUid, // Renamed field
                memoryUid: event.memoryUid,
                metadata: event.metadata,
              ),)
          .toList();

      final request = TrackActivitiesRequest(activities: activities);
      TalkerService.instance.debug('Sending API request: ${request.toJson()}');

      final result = await TrackedActivityApi.trackActivities(request: request);
      TalkerService.instance.debug('API response: $result');

      return result;
    } catch (e, stackTrace) {
      lowLevelCatch(e, stackTrace);
      return null;
    }
  }
}

class _FirebaseAnalyticsLogger implements _EventLogger {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  /// Converts activity type to Firebase event name
  String _getEventName(WhatsevrActivityType type) {
    switch (type) {
      case WhatsevrActivityType.view:
        return 'content_view';
      case WhatsevrActivityType.react:
        return 'user_reaction';
      case WhatsevrActivityType.comment:
        return 'user_comment';
      case WhatsevrActivityType.share:
        return 'content_share';
      case WhatsevrActivityType.system:
        return 'system_event';
    }
  }

  @override
  Future<(int? statusCode, String? message)?> logEvents(
      List<_TrackedActivity> events,) async {
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
          if (event.deviceOs != null)
            ..._cleanDeviceParams({
              'device_os': event.deviceOs,
              'device_model': event.deviceModel,
              'app_version': event.appVersion,
            }),

          // Location context
          'has_location': (event.geoLocationWkb != null).toString(),

          // Event metadata
          if (event.metadata != null) 'event_metadata': event.metadata,
          'event_priority': event.priority.name,
        };

        // Add content-specific parameters
        String? contentType;
        String? contentId;

        if (event.wtvUid != null) {
          contentType = 'video';
          contentId = event.wtvUid;
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
        if (event.commentUid != null || event.commentReplyUid != null) {
          params['interaction_type'] =
              event.commentReplyUid != null ? 'reply' : 'comment';
          if (event.commentUid != null) params['comment_id'] = event.commentUid;
          if (event.commentReplyUid != null) {
            params['comment_reply_id'] = event.commentReplyUid;
          }
        }

        // Log the enhanced event
        final eventName = _getEventName(event.activityType);
        await _analytics.logEvent(
          name: eventName,
          parameters: params.cast<String, Object>(),
        );
      }
      return (200, 'Events logged to Firebase Analytics');
    } catch (e, stackTrace) {
      lowLevelCatch(e, stackTrace);
      return (500, e.toString());
    }
  }

  /// Clean device parameters by removing null values and invalid characters
  Map<String, String> _cleanDeviceParams(Map<String?, String?> params) {
    return Map.fromEntries(
      params.entries.where((e) => e.value != null).map((e) =>
          MapEntry(e.key!, e.value!.replaceAll(RegExp(r'[^\w\s.-]'), '')),),
    );
  }
}
