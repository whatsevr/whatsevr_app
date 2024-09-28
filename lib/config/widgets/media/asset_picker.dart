import 'dart:io';
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

  static void captureImage({
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

  static void pickImageFromGallery({
    bool editImage = true,
    List<WhatsevrAspectRatio> aspectRatios = const [],
    bool withCircleCropperUi = false,
    required Function(File file) onCompleted,
  }) async {
    final List<AssetEntity>? pickedAssets = await AssetPicker.pickAssets(
      AppNavigationService.currentContext!,
      pickerConfig: AssetPickerConfig(
        maxAssets: 1,
        requestType: RequestType.image,
        gridCount: 2,
        pageSize: 20,
        pickerTheme: ThemeData.light().copyWith(
          buttonTheme: const ButtonThemeData(
            buttonColor: Colors.blue,
            textTheme: ButtonTextTheme.primary,
          ),
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
      return;
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

  static void pickVideoFromGallery({
    bool editVideo = true,
    Function(File file)? onCompleted,
  }) async {
    final List<AssetEntity>? pickedAssets = await AssetPicker.pickAssets(
      AppNavigationService.currentContext!,
      pickerConfig: AssetPickerConfig(
        limitedPermissionOverlayPredicate: (permissionState) {
          return permissionState != PermissionState.authorized;
        },
        maxAssets: 1,
        requestType: RequestType.video,
        gridCount: 2,
        pageSize: 20,
        pickerTheme: ThemeData.light().copyWith(
          buttonTheme: const ButtonThemeData(
            buttonColor: Colors.blue,
            textTheme: ButtonTextTheme.primary,
          ),
        ),
      ),
    );

    if (pickedAssets == null || pickedAssets.isEmpty) return;
    final File? pickedVideo = await pickedAssets.first.file;
    if (pickedVideo == null) return;
    if (!editVideo) {
      onCompleted?.call(pickedVideo);
      return;
    }
    File? editedVideo;
    await AppNavigationService.newRoute(
      RoutesName.videoEditor,
      extras: VideoEditorPageArgument(
          videoFile: pickedVideo,
          onCompleted: (File? file) {
            editedVideo = file;
          }),
    );
    if (editedVideo == null) {
      if (!(await pickedVideo.exists())) {
        throw Exception('Picked Video File does not exist');
      }
      onCompleted?.call(pickedVideo);
      return;
    }
    onCompleted?.call(editedVideo!);
  }

  static Future<List<File>?> pickDocuments({bool singleFile = false}) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: !singleFile,
      type: FileType.any,
    );

    if (result == null) return null;

    return result.paths.map((String? path) => File(path!)).toList();
  }
}
