import 'dart:io';
import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:whatsevr_app/config/routes/router.dart';

import 'package:whatsevr_app/utils/file.dart';

class ImageCropperPageArgument {
  final File imageProvider;

  ImageCropperPageArgument({
    required this.imageProvider,
  });
}

class ImageCropperPage extends StatefulWidget {
  const ImageCropperPage({super.key, required this.pageArgument});
  final ImageCropperPageArgument pageArgument;

  @override
  State<ImageCropperPage> createState() => _ImageCropperPageState();
}

class _ImageCropperPageState extends State<ImageCropperPage> {
  final _controller = CropController();
  @override
  void initState() {
    super.initState();
    fileToUint8List(widget.pageArgument.imageProvider).then((value) {
      setState(() {
        image = value;
      });
    });
  }

  Uint8List? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crop Image'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              _controller.crop();
            },
          )
        ],
      ),
      body: Builder(
        builder: (context) {
          if (image == null) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
          return Column(
            children: [
              Expanded(
                child: Crop(
                    image: image!,
                    controller: _controller,
                    onCropped: (image) async {
                      final File file = await uint8BytesToFile(image);
                      AppNavigationService.goBack(result: file);
                    }),
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Text('16:9'),
                        onPressed: () {
                          _controller.aspectRatio = 16 / 9;
                        },
                      ),
                      VerticalDivider(
                        color: Colors.grey,
                        width: 20,
                        thickness: 2,
                        endIndent: 14,
                        indent: 14,
                      ),
                      IconButton(
                        icon: Text('4:3'),
                        onPressed: () {
                          _controller.aspectRatio = 4 / 3;
                        },
                      ),
                      VerticalDivider(
                        color: Colors.grey,
                        width: 20,
                        thickness: 2,
                        endIndent: 14,
                        indent: 14,
                      ),
                      IconButton(
                        icon: Text('1:1'),
                        onPressed: () {
                          _controller.aspectRatio = 1;
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
