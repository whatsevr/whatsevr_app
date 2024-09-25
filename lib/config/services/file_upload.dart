import 'dart:io';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase/supabase.dart';

import 'package:whatsevr_app/constants.dart';
import 'package:whatsevr_app/dev/talker.dart';

import '../api/external/models/business_validation_exception.dart';

class FileUploadService {
  static late final SupabaseStorageClient _supabaseStorageClient;
  static void init() {
    _supabaseStorageClient = SupabaseClient(
      'https://dxvbdpxfzdpgiscphujy.supabase.co',
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR4dmJkcHhmemRwZ2lzY3BodWp5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTA3ODQ3NzksImV4cCI6MjAyNjM2MDc3OX0.9I-obmOReMg-jCrgzpGHTNVqtHSp8VCh1mYyaTjFG-A',
    ).storage;
  }

  static Future<String?> uploadFilesToSST(
    File file, {
    required String userUid,
    required fileType,
    String? fileExtension,
  }) async {
    try {
      if (file.lengthSync() > kMaxMediaFileUploadSizeInGB * 1024 * 1000000) {
        throw BusinessException(
            'File size too large (Max $kMaxMediaFileUploadSizeInGB GB)');
      }
      final String fileName =
          '${userUid}_${fileType}_${DateTime.now().microsecondsSinceEpoch}.${fileExtension ?? file.path.split('.').last}';

      final String uploadStorageResponse = await _supabaseStorageClient
          .from('files') // Replace with your storage bucket name
          .upload(
            fileName,
            file,
            retryAttempts: 3,
          );
      final String supabaseImageUrl =
          '${_supabaseStorageClient.url}/object/public/$uploadStorageResponse';
      TalkerService.instance.info('File uploaded to SST: $supabaseImageUrl');
      return supabaseImageUrl;
    } catch (e, s) {
      productionSafetyCatch(e, s);
      return null;
    }
  }
}
