import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/services/file_upload.dart';
import 'package:whatsevr_app/config/widgets/loading_indicator.dart';
import 'package:whatsevr_app/config/widgets/media/aspect_ratio.dart';

class WTVMiniPlayer extends StatefulWidget {
  final String? videoUrl;
  final String? thumbnail;
  final Function()? onTapFreeArea;
  final bool? loopVideo;
  final double? thumbnailHeightAspectRatio;
  const WTVMiniPlayer({
    super.key,
    required this.videoUrl,
    this.thumbnail,
    this.onTapFreeArea,
    this.loopVideo,
    this.thumbnailHeightAspectRatio,
  });

  @override
  State<WTVMiniPlayer> createState() => _WTVMiniPlayerState();
}

class _WTVMiniPlayerState extends State<WTVMiniPlayer> {
  CachedVideoPlayerPlusController? videoPlayerController;
  bool _isInitializing = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> initiateVideoPlayer() async {
    if (_isInitializing || videoPlayerController?.value.isInitialized == true) return;
    
    try {
      _isInitializing = true;
      setState(() {});
      
      final String adaptiveVideoUrl = generateOptimizedCloudinaryVideoUrl(
        originalUrl: widget.videoUrl!,
        quality: 30,
      );
      
      videoPlayerController ??= CachedVideoPlayerPlusController.networkUrl(
        Uri.parse(adaptiveVideoUrl),
        skipCache: true,
        videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: false),
      );
      
      await videoPlayerController!.initialize();
      videoPlayerController!.setLooping(widget.loopVideo ?? false);
    } catch (e) {
      debugPrint('Error initializing video player: $e');
    } finally {
      _isInitializing = false;
      setState(() {});
    }
  }

  void _pauseVideo() {
    if (_isInitialized) {
      videoPlayerController?.pause();
      setState(() {});
    }
  }

  void _playVideo() async {
    if (!_isInitialized && !_isInitializing) {
      await initiateVideoPlayer();
    }
     
    if (_isInitialized) {
      videoPlayerController?.play();
      setState(() {});
    }
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    super.dispose();
  }

  bool get _isPlaying => videoPlayerController?.value.isPlaying == true;
  bool get _isInitialized => videoPlayerController?.value.isInitialized == true;
  bool get _isMuted => videoPlayerController?.value.volume == 0;
  bool get _isBuffering => _isInitialized && videoPlayerController?.value.isBuffering == true;

  void _toggleVolume() {
    videoPlayerController?.setVolume(_isMuted ? 1.0 : 0.0);
    setState(() {});
  }

  void _seekForward() {
    if (!_isInitialized) return;
    final position = videoPlayerController!.value.position;
    videoPlayerController!.seekTo(position + const Duration(seconds: 20));
  }

  void _seekBackward() {
    if (!_isInitialized) return;
    final position = videoPlayerController!.value.position;
    videoPlayerController!.seekTo(position - const Duration(seconds: 20));
  }

  double get _aspectRatio {
    if (_isInitialized) {
      return videoPlayerController!.value.aspectRatio;
    }
    return widget.thumbnailHeightAspectRatio ?? WhatsevrAspectRatio.landscape.ratio;
  }

  void _handleTap() {
    _pauseVideo();
    if (!_isPlaying) {
      widget.onTapFreeArea?.call();
    }
  }

  void _handlePlayPause() {
    if (_isPlaying) {
      _pauseVideo();
    } else {
      _playVideo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.videoUrl ?? ''),
      onVisibilityChanged: (info) {
        if (info.visibleFraction < 0.1 && _isPlaying) {
          _pauseVideo();
        }
      },
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: _handleTap,
                child: AspectRatio(
                  aspectRatio: _aspectRatio,
                  child: !_isInitialized || !_isPlaying
                      ? ExtendedImage.network(
                          widget.thumbnail ?? MockData.imagePlaceholder('Thumbnail'),
                          width: double.infinity,
                          fit: BoxFit.cover,
                          enableLoadState: false,
                        )
                      : CachedVideoPlayerPlus(videoPlayerController!),
                ),
              ),
              if (_isInitialized && _isBuffering)
                Positioned(
                  left: 8,
                  top: 8,
                  child: SizedBox(
                    width: 18,
                    height: 18,
                    child: WhatsevrLoadingIndicator(
                      showBorder: false, 
                    ),
                  ),
                ),
              if (!_isInitialized && videoPlayerController != null)
                Positioned(
                  right: 8,
                  top: 8,
                  child: WhatsevrLoadingIndicator( 
                    showBorder: false,
                  ),
                ),
              if (!_isPlaying)
                IconButton(
                  padding: EdgeInsets.zero,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                        Colors.black.withOpacity(0.3)),
                  ),
                  icon: const Icon(Icons.play_arrow, color: Colors.white, size: 45),
                  onPressed: _handlePlayPause,
                ),
              if (_isPlaying)
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: Row(
                    children: [
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: _seekBackward,
                        icon: const Icon(Icons.fast_rewind,
                            color: Colors.white, size: 20),
                      ),
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: _seekForward,
                        icon: const Icon(Icons.fast_forward,
                            color: Colors.white, size: 20),
                      ),
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: _toggleVolume,
                        icon: Icon(
                            _isMuted ? Icons.volume_off : Icons.volume_up,
                            color: Colors.white,
                            size: 20),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          if (_isPlaying)
            VideoProgressIndicator(
              videoPlayerController!,
              allowScrubbing: true,
              padding: EdgeInsets.zero,
              colors: VideoProgressColors(
                playedColor: Colors.red,
                bufferedColor: Colors.red.withOpacity(0.5),
                backgroundColor: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}
