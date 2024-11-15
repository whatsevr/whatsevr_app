import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsevr_app/config/routes/router.dart';

class CameraViewPageArgument {
  final Function(File file) onCapture;
  CameraViewPageArgument({
    required this.onCapture,
  });
}

class CameraViewPage extends StatefulWidget {
  final CameraViewPageArgument pageArgument;

  const CameraViewPage({super.key, required this.pageArgument});

  @override
  _CameraViewPageState createState() => _CameraViewPageState();
}

class _CameraViewPageState extends State<CameraViewPage> {
  CameraController? controller;
  @override
  void initState() {
    super.initState();
    availableCameras().then((List<CameraDescription> cameraDescriptions) async {
      if (cameraDescriptions.isEmpty) throw Exception('No cameras available');

      controller = CameraController(
        cameraDescriptions.last,
        ResolutionPreset.veryHigh,
      );
      await controller!.initialize();
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose(); // Dispose the controller when done
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<void>(
        future: controller?.initialize(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              alignment: Alignment.center,
              children: [
                CameraPreview(controller!),
                Positioned(
                  bottom: 20,
                  child: FloatingActionButton(
                    child: const Icon(Icons.camera),
                    onPressed: () async {
                      try {
                        final XFile file = await controller!.takePicture();
                        widget.pageArgument.onCapture(File(file.path));
                        AppNavigationService.goBack();
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CupertinoActivityIndicator());
          }
        },
      ),
    );
  }
}
