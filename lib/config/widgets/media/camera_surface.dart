import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class WhatsevrCameraSurfacePage extends StatefulWidget {
  final CameraController controller;

  const WhatsevrCameraSurfacePage(this.controller, {Key? key})
      : super(key: key);

  @override
  _WhatsevrCameraSurfacePageState createState() =>
      _WhatsevrCameraSurfacePageState();
}

class _WhatsevrCameraSurfacePageState extends State<WhatsevrCameraSurfacePage> {
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
