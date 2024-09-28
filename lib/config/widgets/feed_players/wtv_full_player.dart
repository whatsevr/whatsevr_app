import 'package:cached_chewie_plus/cached_chewie_plus.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/widgets/showAppModalSheet.dart';
import '../../services/file_upload.dart';
import '../media/aspect_ratio.dart';

class WtvFullPlayer extends StatefulWidget {
  final String? videoUrl;
  final String? thumbnail;
  const WtvFullPlayer({
    super.key,
    this.videoUrl,
    this.thumbnail,
  });

  @override
  State<StatefulWidget> createState() {
    return _WtvFullPlayerState();
  }
}

class _WtvFullPlayerState extends State<WtvFullPlayer> {
  CachedVideoPlayerController? videoPlayerController;
  ChewieController? _chewieController;

  int? selectedQuality;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  Future<void> initializePlayer({int? quality}) async {
    // if (videoPlayerController?.value.isPlaying == true) {
    //   return;
    // }

    // Generate optimized video URL based on selected quality
    String adaptiveVideoUrl = generateOptimizedCloudinaryVideoUrl(
      originalUrl: widget.videoUrl!,
      quality: quality,
    );

    videoPlayerController = CachedVideoPlayerController.networkUrl(
      Uri.parse(adaptiveVideoUrl),
      videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: true),
    );
    await videoPlayerController?.initialize();
    _createChewieController();
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    videoPlayerController?.dispose();
    super.dispose();
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      useRootNavigator: true,
      videoPlayerController: videoPlayerController!,
      autoPlay: true,
      looping: false,
      showControlsOnInitialize: false,
      allowFullScreen: true,
      allowMuting: true,
      allowPlaybackSpeedChanging: true,
      zoomAndPan: true,
      showOptions: true,
      draggableProgressBar: true,
      startAt: const Duration(seconds: 0),
      additionalOptions: (context) {
        return [
          if (false)
            OptionItem(
              title: 'Quality',
              iconData: Icons.settings,
              onTap: () {
                showAppModalSheet(
                    draggableScrollable: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Select Video Quality',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        for ((String label, int? quality) record in [
                          ('Auto', null),
                          ('Low', 20),
                          ('Normal', 60),
                          ('Max', 100),
                        ])
                          ListTile(
                            visualDensity: VisualDensity.compact,
                            title: Text(record.$1),
                            leading: selectedQuality == record.$2
                                ? const Icon(Icons.check)
                                : null,
                            onTap: () {
                              selectedQuality = record.$2;
                              Navigator.pop(context);
                              initializePlayer(quality: selectedQuality);
                            },
                          ),
                      ],
                    ));
              },
            ),
        ];
      },
      progressIndicatorDelay: const Duration(milliseconds: 2000),
      aspectRatio: videoPlayerController!.value.aspectRatio,
      hideControlsTimer: const Duration(seconds: 3),
      allowedScreenSleep: false,
      fullScreenByDefault: false,
      showControls: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.red,
        backgroundColor: Colors.white,
        bufferedColor: Colors.blueGrey.withOpacity(0.5),
      ),
      placeholder: Container(
        color: Colors.black,
      ),
      autoInitialize: false,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _chewieController?.videoPlayerController.value.isInitialized == true
        ? AspectRatio(
            aspectRatio:
                _chewieController?.aspectRatio.isAspectRatioLandscapeOrSquare ==
                        true
                    ? _chewieController?.aspectRatio ??
                        WhatsevrAspectRatio.landscape.ratio
                    : WhatsevrAspectRatio.square.ratio,
            child: Chewie(
              controller: _chewieController!,
            ),
          )
        : AspectRatio(
            aspectRatio: WhatsevrAspectRatio.landscape.ratio,
            child: Stack(
              children: [
                ExtendedImage.network(
                  widget.thumbnail ?? MockData.imagePlaceholder('Thumbnail'),
                  width: double.infinity,
                  fit: BoxFit.cover,
                  enableLoadState: false,
                ),
                if (_chewieController
                        ?.videoPlayerController.value.isBuffering ==
                    true)
                  const CupertinoActivityIndicator(),
              ],
            ),
          );
  }
}
