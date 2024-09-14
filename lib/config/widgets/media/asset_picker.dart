import 'dart:io';
import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';
import 'package:whatsevr_app/config/widgets/media/video_editor.dart';

import 'package:whatsevr_app/config/widgets/media/camera_surface.dart';
import 'package:whatsevr_app/config/widgets/media/image_cropper.dart';

class CustomAssetPicker {
  CustomAssetPicker._();

  static Future<File?> captureImage(BuildContext context) async {
    final List<CameraDescription> cameraDescriptions = await availableCameras();
    if (cameraDescriptions.isEmpty) throw Exception('No cameras available');

    final CameraController cameraController = CameraController(
      cameraDescriptions.first,
      ResolutionPreset.ultraHigh,
    );
    await cameraController.initialize();

    final File? capturedFile = await AppNavigationService.newRoute(
      RoutesName.cameraView,
      extras: WhatsevrCameraSurfacePageArgument(controller: cameraController),
    );
    if (capturedFile == null) throw Exception('No image captured');

    return await showWhatsevrImageCropper(capturedFile);
  }

  static Future<File?> pickImageFromGallery(
    BuildContext context, {
    bool editImage = true,
  }) async {
    final List<AssetEntity>? pickedAssets = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        maxAssets: 1,
        requestType: RequestType.image,
      ),
    );

    if (pickedAssets == null || pickedAssets.isEmpty) {
      throw Exception('No images picked');
    }
    if (!editImage) {
      final File? file = await pickedAssets.first.file;
      if (file == null) throw Exception('File does not exist');
      return file;
    }

    final File? imageFile = await pickedAssets.first.file;
    if (imageFile == null) throw Exception('File does not exist');
    return await showWhatsevrImageCropper(imageFile);
  }

  static Future<File?> pickVideoFromGallery(
    BuildContext context, {
    bool editVideo = true,
  }) async {
    final List<AssetEntity>? pickedAssets = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        maxAssets: 1,
        requestType: RequestType.video,
      ),
    );

    if (pickedAssets == null || pickedAssets.isEmpty) {
      throw Exception('No videos picked');
    }
    if (!editVideo) {
      final File? file = await pickedAssets.first.file;
      if (file == null) throw Exception('File does not exist');
      return file;
    }

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
