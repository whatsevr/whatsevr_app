import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'package:gap/gap.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:story_view_advance/controller/story_controller.dart';
import 'package:story_view_advance/utils.dart';
import 'package:story_view_advance/widgets/story_view_advance.dart';
import 'package:whatsevr_app/config/services/file_upload.dart';
import 'package:whatsevr_app/config/widgets/button.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';

import 'package:whatsevr_app/config/mocks/mocks.dart';

import '../../../../../../../config/api/response_model/recommendation_memories.dart';
import '../../../../../../../config/services/launch_url.dart';
import '../../../../../../../config/widgets/refresh_indicator.dart';
import '../../../../bloc/explore_bloc.dart';

class ExplorePageMemoriesPage extends StatelessWidget {
  final ScrollController? scrollController;

  const ExplorePageMemoriesPage({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    scrollController?.addListener(() {
      if (scrollController?.position.pixels ==
          scrollController?.position.maxScrollExtent) {
        context.read<ExploreBloc>().add(LoadMoreMemoriesEvent(
              page: context
                      .read<ExploreBloc>()
                      .state
                      .memoryPaginationData!
                      .currentPage +
                  1,
            ));
      }
    });
    return PadHorizontal(
      child: BlocSelector<ExploreBloc, ExploreState, List<RecommendedMemory>?>(
        selector: (ExploreState state) => state.recommendationMemories,
        builder: (context, data) {
          return MyRefreshIndicator(
            onPullDown: () async {
              context.read<ExploreBloc>().add(LoadMemoriesEvent());
              await Future<void>.delayed(const Duration(seconds: 2));
            },
            child: GridView.builder(
              controller: scrollController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
                childAspectRatio: 3 / 5,
              ),
              itemCount: data?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      showGeneralDialog(
                        context: context,
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return _MemoriesPlayer(
                            memories: data,
                            index: index,
                          );
                        },
                      );
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Colors
                                .primaries[index % Colors.primaries.length],
                            borderRadius: BorderRadius.circular(18.0),
                            image: DecorationImage(
                              image: ExtendedNetworkImageProvider(
                                '${data?[index].userMemories?.first.imageUrl}',
                                cache: true,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          alignment: Alignment.center,
                        ),

                        /// profile avatar
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Container(
                            padding: const EdgeInsets.all(3.0),
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              radius: 24.0,
                              backgroundImage: ExtendedNetworkImageProvider(
                                data?[index].user?.profilePicture ??
                                    MockData.imageAvatar,
                                cache: true,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: <Color>[
                                      Colors.black.withOpacity(0.0),
                                      Colors.black,
                                    ],
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Gap(22),
                                    Text(
                                      data?[index]
                                              .userMemories
                                              ?.first
                                              .caption ??
                                          '',
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 4.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(18.0),
                                    bottomRight: Radius.circular(18.0),
                                  ),
                                ),
                                child: Text(
                                  data?[index].user?.username ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ));
              },
            ),
          );
        },
      ),
    );
  }
}

class _MemoriesPlayer extends StatefulWidget {
  final List<RecommendedMemory>? memories;
  final int index;
  _MemoriesPlayer({
    this.memories,
    required this.index,
  });

  @override
  State<_MemoriesPlayer> createState() => _MemoriesPlayerState();
}

class _MemoriesPlayerState extends State<_MemoriesPlayer> {
  PageController? pageViewController;
  StoryController flutterStoryController = StoryController();
  Duration baseDuration = const Duration(seconds: 5);
  int currentPageIndex = 0;
  int currentMemoryIndex = 0;
  @override
  void initState() {
    super.initState();
    currentPageIndex = widget.index;
    pageViewController = PageController(initialPage: widget.index);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leadingWidth: 22,
        title: Row(
          children: [
            CircleAvatar(
              radius: 16.0,
              backgroundImage: ExtendedNetworkImageProvider(
                widget.memories?[currentPageIndex].user?.profilePicture ??
                    MockData.imageAvatar,
                cache: true,
              ),
            ),
            Gap(8),
            Text(
              widget.memories?[currentPageIndex].user?.username ?? '',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: PageView.builder(
          controller: pageViewController,
          itemCount: widget.memories?.length ?? 0,
          onPageChanged: (index) {
            currentPageIndex = index;
            setState(() {});
          },
          itemBuilder: (context, index) {
            List<UserMemory> userMemories =
                widget.memories?[index].userMemories ?? [];
            return StoryView(
              onVerticalSwipeComplete: (direction) {
                if (direction == Direction.down || direction == Direction.up) {
                  Navigator.pop(context);
                }
              },
              storyItems: [
                for (int i = 0; i < (userMemories.length); i++)
                  userMemories[i].isImage == true
                      ? StoryItem.pageImage(
                          controller: flutterStoryController,
                          url:
                              '${widget.memories?[index].userMemories?[i].imageUrl}',
                          duration: baseDuration,
                        )
                      : userMemories[i].isVideo == true
                          ? StoryItem.pageVideo(
                              generateOptimizedCloudinaryVideoUrl(
                                  originalUrl:
                                      '${widget.memories?[index].userMemories?[i].videoUrl}'),
                              controller: flutterStoryController,
                              duration: Duration(
                                  milliseconds: widget.memories?[index]
                                          .userMemories?[i].videoDurationMs ??
                                      0),
                            )
                          : userMemories[i].isWebsite == true
                              ? StoryItem(
                                  SizedBox(),
                                  duration: baseDuration,
                                )
                              : StoryItem.text(
                                  title: '',
                                  backgroundColor: Colors.black,
                                  duration: baseDuration,
                                ),
              ],
              controller: flutterStoryController,
              onStoryShow: (storyItem, index) {
                currentMemoryIndex = index;
                if (userMemories[index].ctaActionUrl != null &&
                    userMemories[index].ctaActionUrl!.isNotEmpty) {
                  SmartDialog.show(
                    displayTime: baseDuration,
                    maskColor: Colors.transparent,
                    keepSingle: true,
                    usePenetrate: true,
                    alignment: Alignment.bottomCenter,
                    builder: (context) {
                      return Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(8.0),
                        child: WhatsevrButton.filled(
                          label:
                              '${widget.memories?[currentPageIndex].userMemories?[currentMemoryIndex].ctaAction}',
                          onPressed: () {
                            launchWebURL(context,
                                url: widget
                                        .memories?[currentPageIndex]
                                        .userMemories?[currentMemoryIndex]
                                        .ctaActionUrl ??
                                    '');
                          },
                        ),
                      );
                    },
                  );
                } else {
                  SmartDialog.dismiss();
                }
              },
              repeat: widget.memories?.length == 1,
              onComplete: () async {
                if (index < (widget.memories?.length ?? 0) - 1) {
                  pageViewController?.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                }
              },
            );
          }),
    );
  }
}
