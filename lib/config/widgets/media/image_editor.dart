import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:pro_image_editor/models/editor_callbacks/pro_image_editor_callbacks.dart';
import 'package:pro_image_editor/models/editor_configs/pro_image_editor_configs.dart';
import 'package:pro_image_editor/modules/main_editor/main_editor.dart';

import '../../../dev/talker.dart';
import '../../../utils/file.dart';
import '../../routes/router.dart';
import '../app_bar.dart';

class ImageEditorPageArgument {
  final File imageFileToEdit;
  final Function(File file) onCompleted;
  ImageEditorPageArgument(
      {required this.imageFileToEdit, required this.onCompleted,});
}

class ImageEditorPage extends StatelessWidget {
  final ImageEditorPageArgument pageArgument;
  const ImageEditorPage({super.key, required this.pageArgument});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WhatsevrAppBar(title: 'Edit Image'),
      body: ProImageEditor.file(
        pageArgument.imageFileToEdit,
        callbacks: ProImageEditorCallbacks(
          onImageEditingComplete: (Uint8List bytes) async {
            final fileFromBytes = await uint8BytesToFile(bytes);
            if (fileFromBytes == null) {
              TalkerService.instance
                  .error('Error converting bytes to file in ImageEditorPage');
              SmartDialog.showToast('Error editing image');
              return;
            }
            pageArgument.onCompleted(fileFromBytes);
            AppNavigationService.goBack();
          },
        ),
        configs: const ProImageEditorConfigs(
          designMode: ImageEditorDesignModeE.cupertino,
          cropRotateEditorConfigs: CropRotateEditorConfigs(
            enabled: false,
          ),
          imageEditorTheme: ImageEditorTheme(
            background: Colors.white,
            appBarBackgroundColor: Colors.white,
            appBarForegroundColor: Colors.black,
            uiOverlayStyle: SystemUiOverlayStyle.light,
          ),
        ),
      ),
    );
  }
}
