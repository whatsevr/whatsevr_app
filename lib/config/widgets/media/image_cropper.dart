import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

import 'aspect_ratio.dart';

Future<File?> showWhatsevrImageCropper({
  required File imageFile,
}) async {
  try {
// Check if the file exists before cropping
    if (!(await imageFile.exists())) throw Exception('File does not exist');
    List<CropAspectRatioPreset> aspectRatioPresets = [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio16x9,
      CropAspectRatioPreset.ratio4x3,
    ];
    final CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      compressQuality: 100,
      compressFormat: ImageCompressFormat.jpg,
      uiSettings: <PlatformUiSettings>[
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: aspectRatioPresets.first,
          aspectRatioPresets: aspectRatioPresets,
          lockAspectRatio: false,
          statusBarColor: Colors.white,
          backgroundColor: Colors.white,
        ),
        IOSUiSettings(
          aspectRatioLockDimensionSwapEnabled: false,
          aspectRatioPresets: aspectRatioPresets,
          aspectRatioLockEnabled: false,
          resetAspectRatioEnabled: false,
        ),
      ],
    );

    if (croppedFile != null) {
      return File(croppedFile.path);
    }
  } catch (e) {
    print('Error cropping image: $e');
  }
  return null;
}
