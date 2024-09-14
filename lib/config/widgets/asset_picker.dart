import 'dart:io';
import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:whatsevr_app/config/widgets/video_editor.dart';

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
        builder: (_) => CameraPreviewScreen(cameraController),
      ),
    );
    if (capturedFile == null) throw Exception('No image captured');
    // If image is captured, crop it
    return await _cropImage(capturedFile as File);
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
    return await _cropImage(imageFile);
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
    final File? editedVideo = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => VideoEditor(file: videoFile),
      ),
    );
  }

  // Pick any type of document from the file system
  static Future<List<File>?> pickDocuments({bool singleFile = false}) async {
    // Use file picker to allow any file type
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: !singleFile,
      type: FileType.any,
    );

    if (result == null) throw Exception('No documents picked');

    // Convert paths to files
    return result.paths.map((String? path) => File(path!)).toList();
  }

  // Crop the image using ImageCropper
  static Future<File?> _cropImage(File imageFile) async {
    try {
      // Check if the file exists before cropping
      if (!(await imageFile.exists())) throw Exception('File does not exist');
      final CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        uiSettings: <PlatformUiSettings>[
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            minimumAspectRatio: 1.0,
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
}

// Camera preview screen with a floating action button for taking pictures
class CameraPreviewScreen extends StatefulWidget {
  final CameraController controller;

  const CameraPreviewScreen(this.controller, {Key? key}) : super(key: key);

  @override
  _CameraPreviewScreenState createState() => _CameraPreviewScreenState();
}

class _CameraPreviewScreenState extends State<CameraPreviewScreen> {
  @override
  void dispose() {
    widget.controller.dispose(); // Dispose the controller when done
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: widget.controller.initialize(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(widget.controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera),
        onPressed: () async {
          try {
            XFile file = await widget.controller.takePicture();
            Navigator.pop(context, File(file.path));
          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }
}

// Video trimming screen using Trimmer package
