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

import 'package:whatsevr_app/config/widgets/media/aspect_ratio.dart';
import 'package:whatsevr_app/config/widgets/media/image_editor.dart';

class CustomAssetPicker {
  CustomAssetPicker._();

  static Future<void> captureImage({
    required Function(File file)? onCompleted,
    bool cropImage = true,
    bool editImage = true,
    required List<WhatsevrAspectRatio> aspectRatios,
    bool withCircleCropperUi = false,
  }) async {
    File? capturedFile;
    await AppNavigationService.newRoute(
      RoutesName.cameraView,
      extras: CameraViewPageArgument(onCapture: (File file) {
        capturedFile = file;
      }),
    );
    if (capturedFile == null) return;
    if (!cropImage) {
      onCompleted?.call(capturedFile!);
      return;
    }
    File? croppedImage;
    await AppNavigationService.newRoute(
      RoutesName.imageCropper,
      extras: ImageCropperPageArgument(
        imageFileToCrop: capturedFile!,
        aspectRatios: aspectRatios,
        withCircleCropperUi: withCircleCropperUi,
        onCompleted: (File file) {
          croppedImage = file;
        },
      ),
    );
    if (croppedImage == null) throw Exception('No image cropped');
    if (!editImage) {
      onCompleted?.call(croppedImage!);
      return;
    }
    File? editedImage;
    await AppNavigationService.newRoute(
      RoutesName.imageEditor,
      extras: ImageEditorPageArgument(
          imageFileToEdit: croppedImage!,
          onCompleted: (File file) {
            editedImage = file;
          }),
    );
    onCompleted?.call(editedImage ?? croppedImage!);
  }

  static Future<void> pickImageFromGallery({
    bool editImage = true,
    required List<WhatsevrAspectRatio> aspectRatios,
    required bool withCircleCropperUi,
    required Function(File file) onCompleted,
  }) async {
    final List<AssetEntity>? pickedAssets = await AssetPicker.pickAssets(
      AppNavigationService.currentContext!,
      pickerConfig: AssetPickerConfig(
        maxAssets: 1,
        requestType: RequestType.image,
        gridCount: 2,
        pageSize: 20,
        pickerTheme: AssetPicker.themeData(
          Colors.black,
          light: true,
        ),
        shouldAutoplayPreview: true,
      ),
    );

    if (pickedAssets == null || pickedAssets.isEmpty) {
      return;
    }
    File? pickedFile = await pickedAssets.first.file;
    if (pickedFile == null) throw Exception('File does not exist');
    File? croppedImage;
    await AppNavigationService.newRoute(
      RoutesName.imageCropper,
      extras: ImageCropperPageArgument(
        imageFileToCrop: pickedFile,
        aspectRatios: aspectRatios,
        onCompleted: (File file) {
          croppedImage = file;
        },
      ),
    );
    if (croppedImage == null) {
      throw Exception('No image cropped');
    }

    if (!editImage) {
      onCompleted.call(croppedImage!);
      return;
    }
    File? editedImage;
    await AppNavigationService.newRoute(
      RoutesName.imageEditor,
      extras: ImageEditorPageArgument(
          imageFileToEdit: croppedImage!,
          onCompleted: (File file) {
            editedImage = file;
          }),
    );
    onCompleted.call(editedImage ?? croppedImage!);
  }

  static Future<File?> pickVideoFromGallery({
    bool editVideo = true,
  }) async {
    final List<AssetEntity>? pickedAssets = await AssetPicker.pickAssets(
      AppNavigationService.currentContext!,
      pickerConfig: AssetPickerConfig(
        maxAssets: 1,
        requestType: RequestType.video,
        gridCount: 2,
        pageSize: 20,
        pickerTheme: ThemeData.light().copyWith(
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blue,
            textTheme: ButtonTextTheme.primary,
          ),
        ),
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
      RoutesName.videoEditor,
      extras: VideoEditorPageArgument(videoFile: videoFile),
    );
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
