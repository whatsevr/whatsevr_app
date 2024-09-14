import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:whatsevr_app/config/routes/router.dart';

class WhatsevrCameraSurfacePageArgument {
  final CameraController controller;

  WhatsevrCameraSurfacePageArgument({
    required this.controller,
  });
}

class WhatsevrCameraSurfacePage extends StatefulWidget {
  final WhatsevrCameraSurfacePageArgument pageArgument;

  const WhatsevrCameraSurfacePage({super.key, required this.pageArgument});

  @override
  _WhatsevrCameraSurfacePageState createState() =>
      _WhatsevrCameraSurfacePageState();
}

class _WhatsevrCameraSurfacePageState extends State<WhatsevrCameraSurfacePage> {
  late CameraController controller;
  @override
  void initState() {
    super.initState();
    controller = widget.pageArgument.controller;
  }

  @override
  void dispose() {
    controller.dispose(); // Dispose the controller when done
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: controller.initialize(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(controller);
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
            XFile file = await controller.takePicture();
            AppNavigationService.goBack(result: File(file.path));
          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }
}
