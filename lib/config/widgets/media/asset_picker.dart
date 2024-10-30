import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../../../utils/file.dart';
import '../../routes/router.dart';
import '../../routes/routes_name.dart';
import 'aspect_ratio.dart';
import 'camera_surface.dart';
import 'image_cropper.dart';
import 'image_editor.dart';
import 'video_editor.dart';

class CustomAssetPicker {
  CustomAssetPicker._();

  static void captureImage({
    required Function(File file)? onCompleted,
    bool cropImage = true,
    bool editImage = true,
    List<WhatsevrAspectRatio> aspectRatios = WhatsevrAspectRatio.values,
    bool withCircleCropperUi = false,
    int? quality,
  }) async {
    File? capturedFile;
    await AppNavigationService.newRoute(
      RoutesName.cameraView,
      extras: CameraViewPageArgument(onCapture: (File file) {
        capturedFile = file;
      },),
    );
    if (capturedFile == null) return;
    File? compressedFile;
    if (quality != null) {
      compressedFile = await compressImage(capturedFile, quality: quality);
    }

    if (!cropImage) {
      onCompleted?.call(compressedFile ?? capturedFile!);
      return;
    }

    File? croppedImage;
    await AppNavigationService.newRoute(
      RoutesName.imageCropper,
      extras: ImageCropperPageArgument(
        imageFileToCrop: compressedFile ?? capturedFile!,
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
          },),
    );
    onCompleted?.call(editedImage ?? croppedImage!);
  }

  static void pickImageFromGallery({
    bool editImage = true,
    List<WhatsevrAspectRatio> aspectRatios = WhatsevrAspectRatio.values,
    bool withCircleCropperUi = false,
    required Function(File file) onCompleted,
    int? quality,
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
    final File? pickedFile = await pickedAssets.first.file;
    if (pickedFile == null) throw Exception('File does not exist');
    File? compressedFile;
    if (quality != null) {
      compressedFile = await compressImage(pickedFile, quality: quality);
    }
    File? croppedImage;
    await AppNavigationService.newRoute(
      RoutesName.imageCropper,
      extras: ImageCropperPageArgument(
        imageFileToCrop: compressedFile ?? pickedFile,
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
          },),
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
          },),
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

  static void pickDocuments(
      {bool singleFile = true,
      required Function(List<File>) onCompleted,}) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: !singleFile,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result == null) return null;

    onCompleted(result.paths.map((String? path) => File(path!)).toList());
  }
}
