import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/widgets/feed_players/flick_full_player.dart';
import 'package:whatsevr_app/config/widgets/loading_indicator.dart';
import 'package:whatsevr_app/config/widgets/media/aspect_ratio.dart';

showVideoPreviewDialog({BuildContext? context, String? videoUrl}) {
  if (videoUrl == null) return;
  context ??= AppNavigationService.currentContext!;
  showGeneralDialog(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) {
      return _VideoPreviewer(videoUrl: videoUrl);
    },
  );
}

/// full fledged video player
class _VideoPreviewer extends StatefulWidget {
  final String videoUrl;

  const _VideoPreviewer({
    super.key,
    required this.videoUrl,
  });

  @override
  __VideoPreviewerState createState() => __VideoPreviewerState();
}

class __VideoPreviewerState extends State<_VideoPreviewer> {
  late final CachedVideoPlayerPlusController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        CachedVideoPlayerPlusController.networkUrl(Uri.parse(widget.videoUrl))
          ..initialize().then((_) {
            _controller.play();
            if (mounted) {
              setState(() {});
            }
            if (!_controller.value.aspectRatio.isAspectRatioPortrait) {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.landscapeRight,
                DeviceOrientation.landscapeLeft,
              ]);
            }
          });
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized
            ? Stack(
                children: [
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: CachedVideoPlayerPlus(_controller),
                  ),
                  //positioning the player controls
                ],
              )
            : WhatsevrLoadingIndicator(),
      ),
    );
  }
}
