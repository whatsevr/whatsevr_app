import 'dart:io';
import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:gap/gap.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'package:whatsevr_app/config/widgets/app_bar.dart';
import 'package:whatsevr_app/config/widgets/buttons/button.dart';
import 'package:whatsevr_app/config/widgets/loading_indicator.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
import 'package:whatsevr_app/config/widgets/media/aspect_ratio.dart';
import 'package:whatsevr_app/config/widgets/media/asset_picker.dart';

Future<File?> showWhatsevrThumbnailSelectionPage({
  required File videoFile,
  Function? onThumbnailSelected,
  bool allowPickFromGallery = true,
  List<WhatsevrAspectRatio> aspectRatios = WhatsevrAspectRatio.values,
}) async {
  File? file;
  await SmartDialog.show(
    alignment: Alignment.bottomCenter,
    builder: (BuildContext context) {
      return _Ui(
        videoFile: videoFile,
        onThumbnailSelected: (File file0) {
          onThumbnailSelected?.call();
          file = file0;
          SmartDialog.dismiss();
        },
        allowPickFromGallery: allowPickFromGallery,
        aspectRatios: aspectRatios,
      );
    },
  );

  return file;
}

class _Ui extends StatefulWidget {
  final File videoFile;
  final Function(File) onThumbnailSelected;
  final bool allowPickFromGallery;
  final List<WhatsevrAspectRatio> aspectRatios;

  const _Ui({
    required this.videoFile,
    required this.onThumbnailSelected,
    this.allowPickFromGallery = true,
    this.aspectRatios = WhatsevrAspectRatio.values,
  });

  @override
  State<_Ui> createState() => _UiState();
}

class _UiState extends State<_Ui> {
  VideoPlayerController? _controller;
  int videoDurationInMs = 0;
  List<MemoryImage> thumbnails = <MemoryImage>[];
  MemoryImage? selectedThumbnail;

  @override
  void initState() {
    super.initState();
    // Initialize the video controller and ensure the duration is captured correctly
    _controller = VideoPlayerController.file(widget.videoFile)
      ..initialize().then((_) {
        // Ensure video duration is valid

        videoDurationInMs = _controller!.value.duration.inMilliseconds;

        // Once initialized, generate the thumbnails
        generateThumbnails();
      });
  }

  void generateThumbnails() async {
    if (videoDurationInMs <= 0) {
      // Check if video duration is invalid
      print('Invalid video duration');
      return;
    }

    const int thumbnailCount = 20;
    final int interval =
        videoDurationInMs ~/ thumbnailCount; // Ensure distinct intervals

    for (int i = 0; i < thumbnailCount; i++) {
      // Ensure distinct time points for each thumbnail
      final int forDuration = interval * i;
      final MemoryImage? thumbnailFile = await getThumbnailMemoryImage(
        videoFile: widget.videoFile,
        forDuration: forDuration,
      );

      if (thumbnailFile != null) {
        thumbnails.add(thumbnailFile);

        if (i == 0) {
          // Set the first thumbnail as default
          selectedThumbnail = thumbnailFile;
        }
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WhatsevrAppBar(
        title: 'Select Thumbnail',
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              SmartDialog.dismiss();
            },
          ),
        ],
      ),
      body: PadHorizontal(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Builder(
                builder: (BuildContext context) {
                  if (selectedThumbnail == null) {
                    return const WhatsevrLoadingIndicator();
                  }
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: selectedThumbnail!,
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                },
              ),
            ),
            const Gap(8.0),
            SizedBox(
              height: 120,
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    const Gap(8.0),
                scrollDirection: Axis.horizontal,
                itemCount: thumbnails.length,
                itemBuilder: (BuildContext context, int index) {
                  final MemoryImage thumbnail = thumbnails[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedThumbnail = thumbnail;
                      });
                    },
                    child: Stack(
                      children: [
                        ExtendedImage.memory(
                          thumbnail.bytes,
                          fit: BoxFit.cover,
                        ),
                        if (selectedThumbnail == thumbnail)
                          Positioned(
                            top: 4,
                            right: 4,
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.white,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            if (widget.allowPickFromGallery)
              WhatsevrButton.outlined(
                label: 'Pick From Gallery',
                onPressed: () async {
                  CustomAssetPicker.pickImageFromGallery(
                    aspectRatios: widget.aspectRatios,
                    onCompleted: (file) {
                      widget.onThumbnailSelected(file);
                    },
                  );
                },
              ),
            WhatsevrButton.filled(
              label: 'Done',
              onPressed: () async {
                if (selectedThumbnail == null) {
                  SmartDialog.showToast('Please select a thumbnail');
                  return;
                }
                final File? file = await saveImageAsFile(selectedThumbnail!.bytes);
                if (file != null) {
                  widget.onThumbnailSelected(file);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<MemoryImage?> getThumbnailMemoryImage({
  required File videoFile,
  int forDuration = 5000,
}) async {
  try {
    // Generate a thumbnail at the specified time in milliseconds
    final String? tempPath = await VideoThumbnail.thumbnailFile(
      video: videoFile.path,

      imageFormat: ImageFormat.JPEG,
      quality: 70,
      timeMs: forDuration, // Ensure this time is unique for each thumbnail
    );

    if (tempPath == null) {
      print('Failed to generate thumbnail.');
      return null;
    }

    final File thumbnailFile = File(tempPath);
    if (!await thumbnailFile.exists()) {
      print('Thumbnail file does not exist.');
      return null;
    }
    final MemoryImage thumbnailData = MemoryImage(
      File(tempPath ?? '').readAsBytesSync(),
    );
    print('Thumbnail generated for duration: $forDuration');

    return thumbnailData;
  } catch (e) {
    print('Error generating thumbnail: $e');
    return null;
  }
}

Future<File?> getThumbnailFile({
  required File? videoFile,
  int forDuration = 5000,
}) async {
  if (videoFile == null) return null;
  try {
    // Generate a thumbnail at the specified time in milliseconds
    final String? tempPath = await VideoThumbnail.thumbnailFile(
      video: videoFile.path,
      thumbnailPath: videoFile.parent.path,
      imageFormat: ImageFormat.JPEG,
      quality: 70,
      timeMs: forDuration, // Ensure this time is unique for each thumbnail
    );
    final MemoryImage thumbnailData = MemoryImage(
      File(tempPath ?? '').readAsBytesSync(),
    );
    if (tempPath == null) {
      print('Failed to generate thumbnail.');
      return null;
    }

    final File thumbnailFile = File(tempPath);
    if (!await thumbnailFile.exists()) {
      print('Thumbnail file does not exist.');
      return null;
    }
    print('Thumbnail generated for duration: $forDuration');
    print('Thumbnail generated in path: $tempPath');
    return thumbnailFile;
  } catch (e) {
    print('Error generating thumbnail: $e');
    return null;
  }
}

Future<File?> saveImageAsFile(Uint8List bytes) async {
  try {
    final Directory root = await getTemporaryDirectory();
    final String directoryPath = '${root.path}/appName';
    // Create the directory if it doesn't exist
    await Directory(directoryPath).create(recursive: true);
    final String filePath =
        '$directoryPath/${DateTime.now().millisecondsSinceEpoch}.jpg';
    final File file = await File(filePath).writeAsBytes(bytes);
    return file;
  } catch (e) {
    debugPrint(e.toString());
  }
  return null;
}
