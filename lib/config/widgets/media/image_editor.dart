import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pro_image_editor/models/editor_callbacks/pro_image_editor_callbacks.dart';
import 'package:pro_image_editor/models/editor_configs/pro_image_editor_configs.dart';
import 'package:pro_image_editor/modules/main_editor/main_editor.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/widgets/app_bar.dart';
import 'package:whatsevr_app/utils/file.dart';

class ImageEditorPageArgument {
  final File imageFileToEdit;
  final Function(File file) onCompleted;
  ImageEditorPageArgument(
      {required this.imageFileToEdit, required this.onCompleted});
}

class ImageEditorPage extends StatelessWidget {
  final ImageEditorPageArgument pageArgument;
  const ImageEditorPage({super.key, required this.pageArgument});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Edit Image'),
      body: ProImageEditor.file(
        pageArgument.imageFileToEdit,
        callbacks: ProImageEditorCallbacks(
          onImageEditingComplete: (Uint8List bytes) async {
            File? fileFromBytes = await uint8BytesToFile(bytes);
            pageArgument.onCompleted(fileFromBytes);
            AppNavigationService.goBack();
          },
        ),
        configs: ProImageEditorConfigs(
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
