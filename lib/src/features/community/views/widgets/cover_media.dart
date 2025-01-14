import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:whatsevr_app/config/api/response_model/community/community_details.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/src/features/community/bloc/bloc.dart';

class CommunityPageCoverVideoView extends StatelessWidget {
  CommunityPageCoverVideoView({super.key});
  final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityBloc, CommunityState>(
      builder: (BuildContext context, CommunityState state) {
        //show empty container if there is no cover media
        if (state.communityDetailsResponse?.communityCoverMedia?.isEmpty ??
            true) {
          return Container(
            height: 120,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExtendedNetworkImageProvider(
                  MockData.imagePlaceholder('Cover Media'),
                  cache: true,
                ),
                fit: BoxFit.cover,
              ),
            ),
          );
        }
        return Stack(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 16 / 9,
              child: PageView.builder(
                controller: controller,
                itemCount: state.communityDetailsResponse?.communityCoverMedia
                        ?.length ??
                    0,
                itemBuilder: (BuildContext context, int index) {
                  final CommunityCoverMedia? coverMedia = state
                      .communityDetailsResponse?.communityCoverMedia?[index];
                  if (coverMedia?.isVideo == true) {
                    return _CoverVideoUi(
                      videoUrl: coverMedia?.videoUrl,
                      thumbnailUrl: coverMedia?.imageUrl,
                    );
                  }
                  return ExtendedImage.network(
                    coverMedia?.imageUrl ??
                        MockData.imagePlaceholder('Cover Media'),
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                    cache: true,
                    enableLoadState: false,
                  );
                },
              ),
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: 8,
              child: UnconstrainedBox(
                child: SmoothPageIndicator(
                  controller: controller, // PageController
                  count: state.communityDetailsResponse?.communityCoverMedia
                          ?.length ??
                      0,
                  effect: const WormEffect(
                    dotWidth: 8.0,
                    dotHeight: 8.0,
                    activeDotColor: Colors.black,
                    dotColor: Colors.white,
                  ), // your preferred effect
                  onDotClicked: (int index) {},
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CoverVideoUi extends StatefulWidget {
  final String? videoUrl;
  final String? thumbnailUrl;
  const _CoverVideoUi({required this.videoUrl, this.thumbnailUrl});

  @override
  State<_CoverVideoUi> createState() => _CoverVideoUiState();
}

class _CoverVideoUiState extends State<_CoverVideoUi> {
  late CachedVideoPlayerPlusController controller;
  @override
  void initState() {
    super.initState();
    controller = CachedVideoPlayerPlusController.networkUrl(
      Uri.parse('${widget.videoUrl}'),
    )..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
        controller.addListener(() {
          if (controller.value.position == controller.value.duration) {
            controller.seekTo(Duration.zero);
            controller.play();
          }
        });
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        InkWell(
          onTap: () {
            setState(() {
              if (controller.value.isPlaying) {
                controller.pause();
              } else {
                controller.play();
              }
            });
          },
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Builder(
              builder: (BuildContext context) {
                if (controller.value.position == Duration.zero &&
                    !controller.value.isPlaying) {
                  return ExtendedImage.network(
                    widget.thumbnailUrl ??
                        MockData.imagePlaceholder('Cover Media'),
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                    cache: true,
                    enableLoadState: false,
                  );
                }
                return CachedVideoPlayerPlus(controller);
              },
            ),
          ),
        ),
        if (!controller.value.isPlaying)
          IconButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.black38),
            ),
            icon: const Icon(
              Icons.play_arrow,
              size: 40,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                if (controller.value.isPlaying) {
                  controller.pause();
                } else {
                  controller.play();
                  controller.setVolume(1);
                }
              });
            },
          ),
      ],
    );
  }
}
