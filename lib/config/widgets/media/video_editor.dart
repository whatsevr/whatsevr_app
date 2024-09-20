import 'dart:developer';
import 'dart:io';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit_config.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_session.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:ffmpeg_kit_flutter/statistics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:video_editor/video_editor.dart';

import 'package:fraction/fraction.dart';
import 'package:whatsevr_app/config/routes/router.dart';

import 'package:whatsevr_app/config/widgets/app_bar.dart';
import 'package:whatsevr_app/config/widgets/media/aspect_ratio.dart';

class VideoEditorPageArgument {
  final File videoFile;
  final WhatsevrAspectRatio? aspectRatio;
  final Function(File? file) onCompleted;
  VideoEditorPageArgument(
      {required this.videoFile, required this.onCompleted, this.aspectRatio});
}

class VideoEditorPage extends StatefulWidget {
  const VideoEditorPage({super.key, required this.pageArgument});

  final VideoEditorPageArgument pageArgument;

  @override
  State<VideoEditorPage> createState() => _VideoEditorPageState();
}

class _VideoEditorPageState extends State<VideoEditorPage> {
  final ValueNotifier<double> _exportingProgress = ValueNotifier<double>(0.0);
  final ValueNotifier<bool> _isExporting = ValueNotifier<bool>(false);
  final double baseHeight = 60;

  late final VideoEditorController _controller = VideoEditorController.file(
    widget.pageArgument.videoFile,
    minDuration: const Duration(seconds: 15),
    maxDuration: const Duration(hours: 8),
  );

  @override
  void initState() {
    super.initState();
    _controller
        .initialize(aspectRatio: widget.pageArgument.aspectRatio?.ratio)
        .then((_) => setState(() {}))
        .catchError(
      (error) {
        // handle minumum duration bigger than video duration error
        if (error is VideoMinDurationError) {
          throw Exception('Video is too short to be edited');
        }

        AppNavigationService.goBack();
      },
      test: (Object e) => e is VideoMinDurationError,
    );
  }

  @override
  void dispose() async {
    _exportingProgress.dispose();
    _isExporting.dispose();
    _controller.dispose();
    ExportService.dispose();
    super.dispose();
  }

  void _exportVideo() async {
    _exportingProgress.value = 0;
    _isExporting.value = true;

    final VideoFFmpegVideoEditorConfig config = VideoFFmpegVideoEditorConfig(
      _controller,
    );

    await ExportService.runFFmpegCommand(
      await config.getExecuteConfig(),
      onProgress: (Statistics stats) {
        _exportingProgress.value =
            config.getFFmpegProgress(stats.getTime().toInt());
      },
      onError: (Object e, StackTrace s) =>
          SmartDialog.showToast('Error on processing video :('),
      onCompleted: (File file) async {
        _isExporting.value = false;
        widget.pageArgument.onCompleted(file);
        AppNavigationService.goBack();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_isExporting.value,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'Edit',
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: _exportVideo,
            ),
          ],
        ),
        body: _controller.initialized
            ? SafeArea(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          CropGridViewer.preview(controller: _controller),
                          AnimatedBuilder(
                            animation: _controller.video,
                            builder: (_, __) => AnimatedOpacity(
                              opacity: _controller.isPlaying ? 0 : 1,
                              duration: kThemeAnimationDuration,
                              child: GestureDetector(
                                onTap: _controller.video.play,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.play_arrow,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 200,
                      margin: const EdgeInsets.only(top: 10),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: _trimSlider(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable: _isExporting,
                      builder: (_, bool export, Widget? child) => AnimatedSize(
                        duration: kThemeAnimationDuration,
                        child: export ? child : null,
                      ),
                      child: AlertDialog(
                        title: ValueListenableBuilder(
                          valueListenable: _exportingProgress,
                          builder: (_, double value, __) => Text(
                            'Processing video ${(value * 100).ceil()}%',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : const Center(child: CupertinoActivityIndicator()),
        bottomNavigationBar: _topNavBar(),
      ),
    );
  }

  Widget _topNavBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: IconButton(
                onPressed: () =>
                    _controller.rotate90Degrees(RotateDirection.left),
                icon: const Icon(Icons.rotate_left),
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () =>
                    _controller.rotate90Degrees(RotateDirection.right),
                icon: const Icon(Icons.rotate_right),
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        CropPage(controller: _controller),
                  ),
                ),
                icon: const Icon(Icons.crop),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatter(Duration duration) => <String>[
        duration.inMinutes.remainder(60).toString().padLeft(2, '0'),
        duration.inSeconds.remainder(60).toString().padLeft(2, '0'),
      ].join(':');

  List<Widget> _trimSlider() {
    return <Widget>[
      AnimatedBuilder(
        animation: Listenable.merge(<Listenable?>[
          _controller,
          _controller.video,
        ]),
        builder: (_, __) {
          final int duration = _controller.videoDuration.inSeconds;
          final double pos = _controller.trimPosition * duration;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: baseHeight / 4),
            child: Row(
              children: <Widget>[
                Text(formatter(Duration(seconds: pos.toInt()))),
                const Expanded(child: SizedBox()),
                AnimatedOpacity(
                  opacity: _controller.isTrimming ? 1 : 0,
                  duration: kThemeAnimationDuration,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(formatter(_controller.startTrim)),
                      const SizedBox(width: 10),
                      Text(formatter(_controller.endTrim)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(vertical: baseHeight / 4),
        child: TrimSlider(
          controller: _controller,
          height: baseHeight,
          horizontalMargin: baseHeight / 4,
          child: TrimTimeline(
            controller: _controller,
            padding: const EdgeInsets.only(top: 10),
          ),
        ),
      ),
    ];
  }
}

class CropPage extends StatelessWidget {
  const CropPage({super.key, required this.controller});

  final VideoEditorController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: IconButton(
                      onPressed: () =>
                          controller.rotate90Degrees(RotateDirection.left),
                      icon: const Icon(Icons.rotate_left),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () =>
                          controller.rotate90Degrees(RotateDirection.right),
                      icon: const Icon(Icons.rotate_right),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Expanded(
                child: CropGridViewer.edit(
                  controller: controller,
                  rotateCropArea: false,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Center(
                        child: Text(
                          'cancel',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: AnimatedBuilder(
                      animation: controller,
                      builder: (_, __) => Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                onPressed: () =>
                                    controller.preferredCropAspectRatio =
                                        controller.preferredCropAspectRatio
                                            ?.toFraction()
                                            .inverse()
                                            .toDouble(),
                                icon: controller.preferredCropAspectRatio !=
                                            null &&
                                        controller.preferredCropAspectRatio! < 1
                                    ? const Icon(
                                        Icons.panorama_vertical_select_rounded,
                                      )
                                    : const Icon(
                                        Icons.panorama_vertical_rounded),
                              ),
                              IconButton(
                                onPressed: () =>
                                    controller.preferredCropAspectRatio =
                                        controller.preferredCropAspectRatio
                                            ?.toFraction()
                                            .inverse()
                                            .toDouble(),
                                icon: controller.preferredCropAspectRatio !=
                                            null &&
                                        controller.preferredCropAspectRatio! > 1
                                    ? const Icon(
                                        Icons
                                            .panorama_horizontal_select_rounded,
                                      )
                                    : const Icon(
                                        Icons.panorama_horizontal_rounded),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              _buildCropButton(context, null),
                              _buildCropButton(context, 1.toFraction()),
                              _buildCropButton(
                                context,
                                Fraction.fromString('9/16'),
                              ),
                              _buildCropButton(
                                  context, Fraction.fromString('3/4')),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: IconButton(
                      onPressed: () {
                        // WAY 1: validate crop parameters set in the crop view
                        controller.applyCacheCrop();
                        // WAY 2: update manually with Offset values
                        // controller.updateCrop(const Offset(0.2, 0.2), const Offset(0.8, 0.8));
                        Navigator.pop(context);
                      },
                      icon: Center(
                        child: Text(
                          'done',
                          style: TextStyle(
                            color:
                                const CropGridStyle().selectedBoundariesColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCropButton(BuildContext context, Fraction? f) {
    if (controller.preferredCropAspectRatio != null &&
        controller.preferredCropAspectRatio! > 1) f = f?.inverse();

    return Flexible(
      child: TextButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: controller.preferredCropAspectRatio == f?.toDouble()
              ? Colors.grey.shade800
              : null,
          foregroundColor: controller.preferredCropAspectRatio == f?.toDouble()
              ? Colors.white
              : null,
          textStyle: Theme.of(context).textTheme.bodySmall,
        ),
        onPressed: () => controller.preferredCropAspectRatio = f?.toDouble(),
        child: Text(f == null ? 'free' : '${f.numerator}:${f.denominator}'),
      ),
    );
  }
}

class ExportService {
  static Future<void> dispose() async {
    final List<FFmpegSession> executions = await FFmpegKit.listSessions();
    if (executions.isNotEmpty) await FFmpegKit.cancel();
  }

  static Future<FFmpegSession> runFFmpegCommand(
    FFmpegVideoEditorExecute execute, {
    required void Function(File file) onCompleted,
    void Function(Object, StackTrace)? onError,
    void Function(Statistics)? onProgress,
  }) {
    log('FFmpeg start process with command = ${execute.command}');
    return FFmpegKit.executeAsync(
      execute.command,
      (FFmpegSession session) async {
        final String state =
            FFmpegKitConfig.sessionStateToString(await session.getState());
        final ReturnCode? code = await session.getReturnCode();

        if (ReturnCode.isSuccess(code)) {
          onCompleted(File(execute.outputPath));
        } else {
          if (onError != null) {
            onError(
              Exception(
                'FFmpeg process exited with state $state and return code $code.\n${await session.getOutput()}',
              ),
              StackTrace.current,
            );
          }
          return;
        }
      },
      null,
      onProgress,
    );
  }
}
