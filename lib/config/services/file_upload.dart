import 'dart:io';

import 'package:supabase/supabase.dart';

import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/foundation.dart';
import 'package:whatsevr_app/constants.dart';
import 'package:whatsevr_app/dev/talker.dart';

import '../api/external/models/business_validation_exception.dart';

class FileUploadService {
  static late final SupabaseStorageClient _supabaseStorageClient;
  static late final Cloudinary cloudinary;
  static void init() {
    _supabaseStorageClient = SupabaseClient(
      'https://dxvbdpxfzdpgiscphujy.supabase.co',
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR4dmJkcHhmemRwZ2lzY3BodWp5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTA3ODQ3NzksImV4cCI6MjAyNjM2MDc3OX0.9I-obmOReMg-jCrgzpGHTNVqtHSp8VCh1mYyaTjFG-A',
    ).storage;
    cloudinary = Cloudinary.signedConfig(
      cloudName: 'whatsevr',
      apiKey: '217516839814951',
      apiSecret: 'fIJspKtYGXNA4IER3QrEyB4Sa2I',
    );
  }

  static Future<String?> uploadFilesToSupabase(
    File file, {
    required String userUid,
    required fileRelatedTo,
    String? fileExtension,
  }) async {
    try {
      if (file.lengthSync() > kMaxMediaFileUploadSizeInGB * 1024 * 1000000) {
        throw BusinessException(
            'File size too large (Max $kMaxMediaFileUploadSizeInGB GB)');
      }
      final String fileName =
          '${userUid}_${fileRelatedTo}_${DateTime.now().microsecondsSinceEpoch}.$fileExtension';

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
      lowLevelCatch(e, s);
      return null;
    }
  }

  static Future<String?> uploadFileToCloudinary(
    File file, {
    required String userUid,
    required String fileRelatedTo,
    String? fileExtension,
  }) async {
    try {
      final String fileName =
          '${userUid}_${fileRelatedTo}_${DateTime.now().microsecondsSinceEpoch}.$fileExtension';

      CloudinaryResponse response = await cloudinary.upload(
          file: file.path,
          fileBytes: file.readAsBytesSync(),
          resourceType: CloudinaryResourceType.auto,
          folder: 'public',
          optParams: {},
          fileName: fileName,
          progressCallback: (count, total) {
            debugPrint('Cloudinary.upload progress: $count/$total');
          });

      if (!response.isSuccessful || response.secureUrl == null) {
        throw BusinessException('Failed to upload file to Cloudinary');
      }

      return response.secureUrl;
    } catch (e, s) {
      lowLevelCatch(e, s);
      return null;
    }
  }
}

String generateOptimizedCloudinaryVideoUrl({
  required String originalUrl, // Original Cloudinary URL

  // Custom Streaming Profile (e.g., sp_hd)
  int? quality, // Manual Quality Control (e.g., q_50)
  bool autoFormat = true, // f_auto for device-specific format
  bool originalQuality = false, // q_auto for network-based quality
  bool dprAuto = true, // Auto-adjust based on device pixel density
  String cacheControl =
      'max-age=${Duration.secondsPerDay * 365}', // Custom cache control (e.g., max-age=3600)
}) {
  if (!originalUrl.contains('res.cloudinary.com')) {
    return originalUrl;
  }
  if (originalQuality) {
    return originalUrl;
  }
  // Split URL at "/upload/" for transformation insertion
  final uploadIndex = originalUrl.indexOf('/upload/');
  final versionIndex = originalUrl.indexOf('/v');

  if (uploadIndex == -1 || versionIndex == -1) {
    throw ArgumentError('Invalid Cloudinary URL format');
  }

  // List to hold the transformations
  List<String> transformations = [];

  // Manual Quality Control
  if (quality != null) {
    transformations.add('q_$quality');
  } else {
    transformations.add('q_auto');
  }

  // Auto-format for device-specific format
  if (autoFormat) {
    transformations.add('f_auto:video');
  }

  // Device Pixel Ratio auto-adjustment
  if (dprAuto) {
    transformations.add('dpr_auto');
  }

  // Insert the transformations in the URL
  String optimizedUrl = originalUrl.substring(0, uploadIndex + 8);
  if (transformations.isNotEmpty) {
    optimizedUrl += '${transformations.join(',')}/';
  }
  optimizedUrl += originalUrl.substring(uploadIndex + 8);

  // Append CDN-level caching as a query parameter, if provided
  optimizedUrl += '?_cache_control=$cacheControl';
  debugPrint('Optimized Cloudinary URL: $optimizedUrl');
  return optimizedUrl;
}
