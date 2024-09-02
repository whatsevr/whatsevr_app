import 'dart:io';


import 'package:flutter/foundation.dart';
import 'package:supabase/supabase.dart';

class FileUploadService {
  static late final SupabaseStorageClient _supabaseStorageClient;
  static void init() {
    _supabaseStorageClient = SupabaseClient(
      'https://dxvbdpxfzdpgiscphujy.supabase.co',
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR4dmJkcHhmemRwZ2lzY3BodWp5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTA3ODQ3NzksImV4cCI6MjAyNjM2MDc3OX0.9I-obmOReMg-jCrgzpGHTNVqtHSp8VCh1mYyaTjFG-A',
    ).storage;
  }

  static Future<String?> uploadFiles(File file) async {
    try {
      //restrict file size to 50MB
      if (file.lengthSync() > 50000000) {
        throw ('File size too large (Max 50MB)');
      }
      final String fileName =
          '${DateTime.now().microsecondsSinceEpoch}${file.path.split('.').last}';

      final String uploadStorageResponse = await _supabaseStorageClient
          .from('files') // Replace with your storage bucket name
          .upload(
            fileName,
            file,
          );
      final String supabaseImageUrl =
          '${_supabaseStorageClient.url}/object/public/$uploadStorageResponse';
      debugPrint('File URL: $supabaseImageUrl');
      return supabaseImageUrl;
    } catch (e) {
      if (kDebugMode) rethrow;
      throw ('Error uploading file');
    }
  }
}
