import 'dart:io';
import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/widgets/app_bar.dart';
import 'package:whatsevr_app/config/widgets/media/aspect_ratio.dart';

import 'package:whatsevr_app/utils/file.dart';

class ImageCropperPageArgument {
  final File imageProvider;
  final List<WhatsevrAspectRatio> aspectRatios;
  final bool withCircleCropperUi;
  ImageCropperPageArgument({
    required this.imageProvider,
    this.aspectRatios = WhatsevrAspectRatio.values,
    this.withCircleCropperUi = false,
  });
}

class ImageCropperPage extends StatefulWidget {
  const ImageCropperPage({super.key, required this.pageArgument});
  final ImageCropperPageArgument pageArgument;

  @override
  State<ImageCropperPage> createState() => _ImageCropperPageState();
}

class _ImageCropperPageState extends State<ImageCropperPage> {
  final CropController _controller = CropController();
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
      appBar: CustomAppBar(
        title: 'Crop',
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
                  },
                  interactive: true,
                  withCircleUi: widget.pageArgument.withCircleCropperUi,
                  aspectRatio: widget.pageArgument.aspectRatios.length == 1
                      ? widget.pageArgument.aspectRatios.first.ratio
                      : null,
                  fixCropRect: true,
                  baseColor: Colors.white,
                  initialSize: 0.9, //rect size
                  maskColor: Colors.white.withAlpha(120),
                  progressIndicator: const CupertinoActivityIndicator(),
                  radius: 20,
                  willUpdateScale: (newScale) {
                    //max zoom level
                    return newScale < 8;
                  },
                  cornerDotBuilder: (size, edgeAlignment) => const DotControl(
                    color: Colors.black,
                    padding: 10,
                  ),
                  clipBehavior: Clip.none,
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                height: 50,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.pageArgument.aspectRatios.length,
                  separatorBuilder: (context, index) => VerticalDivider(),
                  itemBuilder: (context, index) {
                    final WhatsevrAspectRatio aspectRatio =
                        widget.pageArgument.aspectRatios[index];
                    return IconButton(
                      icon: Text(
                          '${aspectRatio.label}(${aspectRatio.valueLabel})'),
                      onPressed: () {
                        _controller.aspectRatio = aspectRatio.ratio;
                      },
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
