import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsevr_app/config/widgets/feed_players/flick_full_player.dart';
import 'package:whatsevr_app/config/widgets/media/aspect_ratio.dart';

class PreviewersPageArguments {
  final String? videoUrl;

  const PreviewersPageArguments({
    this.videoUrl,
  });
}

class PreviewersPage extends StatelessWidget {
  final PreviewersPageArguments pageArguments;

  const PreviewersPage({
    super.key,
    required this.pageArguments,
  });

  @override
  Widget build(BuildContext context) {
    return pageArguments.videoUrl != null
        ? _VideoPreviewer(
            videoUrl: pageArguments.videoUrl!,
          )
        : const Center(
            child: Text('Nothing to preview'),
          );
  }
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
            if (mounted) {
              setState(() {});
            }
          });
    if (!_controller.value.aspectRatio.isAspectRatioPortrait) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    }
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
    return _controller.value.isInitialized
        ? Stack(
            children: [
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: CachedVideoPlayerPlus(_controller),
              ),
              //positioning the player controls
            ],
          )
        : const Center(
            child: CupertinoActivityIndicator(),
          );
  }
}
