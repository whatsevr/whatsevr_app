import 'dart:io';
import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../../dev/talker.dart';
import '../../../utils/file.dart';
import '../../routes/router.dart';
import '../app_bar.dart';
import '../loading_indicator.dart';
import 'aspect_ratio.dart';

class ImageCropperPageArgument {
  final File imageFileToCrop;
  final List<WhatsevrAspectRatio> aspectRatios;
  final bool withCircleCropperUi;
  final Function(File file) onCompleted;
  ImageCropperPageArgument({
    required this.imageFileToCrop,
    this.aspectRatios = WhatsevrAspectRatio.values,
    this.withCircleCropperUi = false,
    required this.onCompleted,
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
    fileToUint8List(widget.pageArgument.imageFileToCrop)
        .then((Uint8List? value) {
      setState(() {
        imageBytes = value;
      });
    });
  }

  Uint8List? imageBytes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WhatsevrAppBar(
        title: 'Crop',
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              _controller.crop();
            },
          ),
        ],
      ),
      body: Builder(
        builder: (BuildContext context) {
          if (imageBytes == null) {
            return const Center(
              child: WhatsevrLoadingIndicator(),
            );
          }
          return Column(
            children: <Widget>[
              Expanded(
                child: Crop(
                  image: imageBytes!,
                  controller: _controller,
                  onCropped: (Uint8List image) async {
                    final File? file = await uint8BytesToFile(image);
                    if (file == null) {
                      TalkerService.instance
                          .error('Error converting bytes to file');
                      SmartDialog.showToast('Error cropping image');
                      return;
                    }
                    widget.pageArgument.onCompleted(file);
                    AppNavigationService.goBack();
                  },
                  interactive: true,
                  withCircleUi: widget.pageArgument.withCircleCropperUi,
                  aspectRatio: widget.pageArgument.aspectRatios.isEmpty
                      ? null
                      : widget.pageArgument.aspectRatios.first.ratio,
                  fixCropRect: true,
                  baseColor: Colors.white,
                  initialSize: 0.9, //rect size
                  maskColor: Colors.white.withAlpha(120),
                  progressIndicator: const WhatsevrLoadingIndicator(),
                  radius: 20,
                  willUpdateScale: (double newScale) {
                    //max zoom level
                    return newScale < 8;
                  },
                  cornerDotBuilder:
                      (double size, EdgeAlignment edgeAlignment) =>
                          const DotControl(
                    color: Colors.black,
                    padding: 10,
                  ),
                  clipBehavior: Clip.none,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                height: 50,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.pageArgument.aspectRatios.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const VerticalDivider(),
                  itemBuilder: (BuildContext context, int index) {
                    final WhatsevrAspectRatio aspectRatio =
                        widget.pageArgument.aspectRatios[index];
                    return IconButton(
                      icon: Text(
                        '${aspectRatio.label}(${aspectRatio.valueLabel})',
                      ),
                      onPressed: () {
                        _controller.aspectRatio = aspectRatio.ratio;
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
