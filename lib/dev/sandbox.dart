import 'dart:io';
import 'package:flutter/material.dart';
import 'package:whatsevr_app/config/widgets/media/asset_picker.dart'; // Assuming this is where CustomAssetPicker is
import 'package:video_player/video_player.dart';

import '../config/widgets/media/aspect_ratio.dart';

class DeveloperPage extends StatefulWidget {
  const DeveloperPage({super.key});

  @override
  State<DeveloperPage> createState() => _DeveloperPageState();
}

class _DeveloperPageState extends State<DeveloperPage> {
  File? _capturedImage;
  File? _pickedVideos;
  List<File>? _pickedDocs;
  VideoPlayerController? _videoPlayerController;

  // Method to pick/capture image
  Future<void> _captureImage() async {
    try {
      final File? image = await CustomAssetPicker.captureImage(
        aspectRatios: imagePostAspectRatio,
      );
      if (image != null) {
        setState(() {
          _capturedImage = image;
        });
      }
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  // Method to pick videos and initialize the video player
  Future<void> _pickVideos() async {
    try {
      final File? videos =
          await CustomAssetPicker.pickVideoFromGallery(editVideo: true);
      if (videos != null) {
        setState(() {
          _pickedVideos = videos;
          _videoPlayerController = VideoPlayerController.file(videos)
            ..initialize().then((_) {
              setState(() {}); // Rebuild UI after initializing the controller
              _videoPlayerController?.play(); // Auto-play the video
            });
        });
      }
    } catch (e) {
      print('Error picking videos: $e');
    }
  }

  // Method to pick documents
  Future<void> _pickDocuments() async {
    try {
      final List<File>? docs = await CustomAssetPicker.pickDocuments();
      if (docs != null) {
        setState(() {
          _pickedDocs = docs;
        });
      }
    } catch (e) {
      print('Error picking documents: $e');
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sandbox'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Buttons for different actions
          for (var itm in [
            ('Open Camera', _captureImage),
            (
              'Pick Images',
              () {
                CustomAssetPicker.pickImageFromGallery(
                        aspectRatios: videoPostAspectRatio)
                    .then((images) {
                  if (images != null) {
                    setState(() {
                      _capturedImage = images;
                    });
                  }
                });
              }
            ),
            ('Pick Videos', _pickVideos),
            ('Pick Documents', _pickDocuments),
          ])
            TextButton(
              onPressed: itm.$2,
              child: Text(itm.$1),
            ),

          // Display captured image
          if (_capturedImage != null) ...[
            const SizedBox(height: 20),
            const Text('Captured Image:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Image.file(_capturedImage!, height: 200),
          ],

          // Display picked video and video player
          if (_pickedVideos != null) ...[
            const SizedBox(height: 20),
            const Text('Picked Video:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            if (_videoPlayerController != null &&
                _videoPlayerController!.value.isInitialized)
              AspectRatio(
                aspectRatio: _videoPlayerController!.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController!),
              ),
            Text(_pickedVideos!.path),
          ],

          // Display picked documents
          if (_pickedDocs != null && _pickedDocs!.isNotEmpty) ...[
            const SizedBox(height: 20),
            const Text('Picked Documents:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            for (var doc in _pickedDocs!) Text(doc.path),
          ],
        ],
      ),
    );
  }
}
