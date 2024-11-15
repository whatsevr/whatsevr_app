import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:whatsevr_app/dev/talker.dart';

class BusinessException implements Exception {
  final String message;
  BusinessException(this.message);

  @override
  String toString() => message ?? 'BusinessException';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BusinessException && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

// low level function to handle production errors
void lowLevelCatch(dynamic e, StackTrace stackTrace) {
  // Log the error to TalkerService with the stack trace
  TalkerService.instance.error(e.toString(), stackTrace);

  // Handle BusinessValidationException specifically
  if (e is BusinessException) {
    throw e;
  }

  // Handle SocketException (network issues)
  if (e is SocketException) {
    final errorMessage = 'Network error: ${e.message}';
    TalkerService.instance.error(errorMessage, stackTrace);
    FirebaseCrashlytics.instance.recordError(e, stackTrace);
    throw BusinessException(errorMessage);
  }

  // Handle DioException (HTTP errors)
  if (e is DioException) {
    FirebaseCrashlytics.instance.recordError(e, stackTrace);

    final statusCode = e.response?.statusCode;
    final errorMessage = e.response?.data['message'] ?? e.message;

    if (statusCode == 401) {
      throw BusinessException('Unauthorized: $errorMessage');
    } else if (statusCode == 403) {
      throw BusinessException('Forbidden: $errorMessage');
    } else if (statusCode == 404) {
      throw BusinessException('Not found: $errorMessage');
    } else if (statusCode == 500) {
      throw BusinessException('Internal server error: $errorMessage');
    } else {
      throw BusinessException(
          'HTTP error: $errorMessage (Status code: $statusCode)',);
    }
  }

  // Handle any other exceptions
  if (kDebugMode) {
    throw e; // Re-throw for debugging purposes
  } else {
    // Log any unexpected error silently to Firebase Crashlytics
    FirebaseCrashlytics.instance.recordError(e, stackTrace);
  }
}

// High level function to handle and show error messages
void highLevelCatch(dynamic e, stackTrace) {
  SmartDialog.dismiss();
  if (e is BusinessException) {
    SmartDialog.showToast(e.message);
  } else {
    if (kDebugMode) throw e;
    SmartDialog.showToast('Something went wrong');
    TalkerService.instance.error(e.toString(), stackTrace);
  }
}
