import 'dart:io';
import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';
import 'package:whatsevr_app/config/widgets/media/video_editor.dart';

import 'camera_surface.dart';
import 'image_cropper.dart';

class CustomAssetPicker {
  CustomAssetPicker._();

  // Open camera, capture an image, and crop the result
  static Future<File?> captureImage(BuildContext context) async {
    // Retrieve available cameras
    final List<CameraDescription> cameraDescriptions = await availableCameras();
    if (cameraDescriptions.isEmpty) throw Exception('No cameras available');

    // Initialize the camera controller
    final CameraController cameraController = CameraController(
      cameraDescriptions.first,
      ResolutionPreset.ultraHigh,
    );
    await cameraController.initialize();

    // Navigate to camera preview screen
    final capturedFile = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => WhatsevrCameraSurfacePage(cameraController),
      ),
    );
    if (capturedFile == null) throw Exception('No image captured');
    // If image is captured, crop it
    return await showWhatsevrImageCropper(capturedFile as File);
  }

  // Pick images from the gallery and optionally crop them
  static Future<File?> pickImageFromGallery(
    BuildContext context, {
    bool editImage = true,
  }) async {
    // Pick image assets using WeChat-style picker
    final List<AssetEntity>? pickedAssets = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        maxAssets: 1,
        requestType: RequestType.image,
      ),
    );

    if (pickedAssets == null || pickedAssets.isEmpty)
      throw Exception('No images picked');
    if (!editImage) {
      // If editImage is false, return the file directly
      final File? file = await pickedAssets.first.file;
      if (file == null) throw Exception('File does not exist');
      return file;
    }
    // Convert the selected assets to files and crop them if needed
    final File? imageFile = await pickedAssets.first.file;
    if (imageFile == null) throw Exception('File does not exist');
    return await showWhatsevrImageCropper(imageFile);
  }

  // Pick videos from the gallery, trim and crop them
  static Future<File?> pickVideoFromGallery(
    BuildContext context, {
    bool editVideo = false,
  }) async {
    // Pick video assets using WeChat-style picker
    final List<AssetEntity>? pickedAssets = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        maxAssets: 1,
        requestType: RequestType.video,
      ),
    );

    if (pickedAssets == null || pickedAssets.isEmpty)
      throw Exception('No videos picked');
    if (!editVideo) {
      // If editVideo is false, return the file directly
      final File? file = await pickedAssets.first.file;
      if (file == null) throw Exception('File does not exist');
      return file;
    }
    // Convert assets to files, trim and crop the videos
    final File? videoFile = await pickedAssets.first.file;
    if (videoFile == null) throw Exception('File does not exist');
    final File? editedVideo = await AppNavigationService.newRoute(
        RoutesName.editVideo,
        extras: VideoEditorPageArgument(videoFile: videoFile));
    if (editedVideo == null) return videoFile;
    return editedVideo;
  }

  static Future<List<File>?> pickDocuments({bool singleFile = false}) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: !singleFile,
      type: FileType.any,
    );

    if (result == null) throw Exception('No documents picked');

    return result.paths.map((String? path) => File(path!)).toList();
  }
}
