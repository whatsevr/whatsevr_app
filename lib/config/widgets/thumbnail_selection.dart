import 'dart:io';
import 'dart:typed_data';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ThumbnailSelectionPage extends StatefulWidget {
  final File videoFile;
  const ThumbnailSelectionPage({super.key, required this.videoFile});

  @override
  State<ThumbnailSelectionPage> createState() => _ThumbnailSelectionPageState();
}

class _ThumbnailSelectionPageState extends State<ThumbnailSelectionPage> {
  VideoPlayerController? _controller;
  int videoDurationInMs = 0;
  List<MemoryImage> thumbnails = [];
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
      print("Invalid video duration");
      return;
    }

    const int thumbnailCount = 20;
    final int interval =
        videoDurationInMs ~/ thumbnailCount; // Ensure distinct intervals

    for (int i = 0; i < thumbnailCount; i++) {
      // Ensure distinct time points for each thumbnail
      final int forDuration = interval * i;
      final MemoryImage? thumbnailFile = await getThumbnailMemoryImage(
          videoFile: widget.videoFile, forDuration: forDuration);

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
      appBar: AppBar(
        title: const Text('Select Thumbnail'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Builder(
              builder: (context) {
                if (selectedThumbnail == null) {
                  return const CupertinoActivityIndicator();
                }
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
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
            height: 200,
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
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedThumbnail == thumbnail
                            ? Colors.black
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: ExtendedImage.memory(
                      thumbnail.bytes,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          MaterialButton(
            minWidth: double.infinity,
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: () async {
              File? file = await saveImageAsFile(selectedThumbnail!.bytes);
              Navigator.of(context).pop(file);
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }
}

Future<MemoryImage?> getThumbnailMemoryImage(
    {required File videoFile, int forDuration = 5000}) async {
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
    MemoryImage? thumbnailData = MemoryImage(
      File(tempPath ?? '').readAsBytesSync(),
    );
    print('Thumbnail generated for duration: $forDuration');

    return thumbnailData;
  } catch (e) {
    print('Error generating thumbnail: $e');
    return null;
  }
}

Future<File?> getThumbnailFile(
    {required File videoFile, int forDuration = 5000}) async {
  try {
    // Generate a thumbnail at the specified time in milliseconds
    final String? tempPath = await VideoThumbnail.thumbnailFile(
      video: videoFile.path,
      thumbnailPath: videoFile.parent.path,
      imageFormat: ImageFormat.JPEG,
      quality: 70,
      timeMs: forDuration, // Ensure this time is unique for each thumbnail
    );
    MemoryImage? thumbnailData = MemoryImage(
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
    Directory root = await getTemporaryDirectory();
    String directoryPath = '${root.path}/appName';
    // Create the directory if it doesn't exist
    await Directory(directoryPath).create(recursive: true);
    String filePath =
        '$directoryPath/${DateTime.now().millisecondsSinceEpoch}.jpg';
    final file = await File(filePath).writeAsBytes(bytes);
    return file;
  } catch (e) {
    debugPrint(e.toString());
  }
  return null;
}
