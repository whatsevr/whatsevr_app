

import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';

class MediaPreviewerPageArguments {
  final String videoUrl;
  const MediaPreviewerPageArguments({
    required this.videoUrl,
  });
}

class MediaPreviewerPage extends StatefulWidget {
  final MediaPreviewerPageArguments pageArguments;

  const MediaPreviewerPage({
    super.key,
    required this.pageArguments,
  });

  @override
  State<StatefulWidget> createState() {
    return _MediaPreviewerPageState();
  }
}

class _MediaPreviewerPageState extends State<MediaPreviewerPage> {
  CachedVideoPlayerPlusController? videoPlayerController;

  int? bufferDelay;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {

    videoPlayerController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    videoPlayerController = CachedVideoPlayerPlusController.networkUrl(
      Uri.parse(widget.pageArguments.videoUrl),
    );
    await videoPlayerController!.initialize();

    setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[

        ],
      ),
    );
  }
}
