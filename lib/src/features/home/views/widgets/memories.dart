import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/api/external/models/memory.dart';

import 'package:whatsevr_app/config/api/response_model/private_recommendation/memories.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/widgets/max_scroll_listener.dart';
import 'package:whatsevr_app/config/widgets/media/aspect_ratio.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
import 'package:whatsevr_app/config/widgets/refresh_indicator.dart';
import 'package:whatsevr_app/src/features/details/memory/views/memories.dart';
import 'package:whatsevr_app/src/features/home/bloc/home_bloc.dart';

class HomePageMemoriesView extends StatelessWidget {
  final ScrollController? scrollController=ScrollController();

   HomePageMemoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    onReachingEndOfTheList(
         context,
     scrollController: scrollController,
      execute: () {
        context.read<HomeBloc>().add(
              LoadMoreMemoriesEvent(
                page: context
                        .read<HomeBloc>()
                        .state
                        .memoryPaginationData!
                        .currentPage +
                    1,
              ),
            );
      },
    );

    return PadHorizontal(
      child: BlocSelector<HomeBloc, HomeState, List<RecommendedMemory>?>(
        selector: (HomeState state) => state.recommendationMemories,
        builder: (context, data) {
          return ListView.separated(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (BuildContext context, int index) =>
                const Gap(4.0),
          
            itemCount: data?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return AspectRatio(
                aspectRatio: WhatsevrAspectRatio.vertical9by16.ratio,
                child: GestureDetector(
                  onTap: () {
                    showMemoriesPlayer(
                      context,
                      uiMemoryGroups: [
                        for (RecommendedMemory memoryGroup in data ?? [])
                          UiMemoryGroup(
                            userUid: memoryGroup.userUid,
                            profilePicture: memoryGroup.user?.profilePicture,
                            username: memoryGroup.user?.username,
                            uiMemoryGroupItems: [
                              for (UserMemory? memory
                                  in memoryGroup.userMemories ?? [])
                                UiMemoryGroupItems(
                                  isImage: memory?.isImage,
                                  imageUrl: memory?.imageUrl,
                                  isVideo: memory?.isVideo,
                                  videoUrl: memory?.videoUrl,
                                  videoDurationMs: memory?.videoDurationMs,
                                  caption: memory?.caption,
                                  ctaAction: memory?.ctaAction,
                                  ctaActionUrl: memory?.ctaActionUrl,
                                  createdAt: memory?.createdAt,
                                ),
                            ],
                          ),
                      ],
                      startGroupIndex: index,
                      startMemoryIndex: 0,
                    );
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color:
                              Colors.primaries[index % Colors.primaries.length],
                          borderRadius: BorderRadius.circular(8.0),
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
                            radius: 18.0,
                            backgroundImage: ExtendedNetworkImageProvider(
                              data?[index].user?.profilePicture ??
                                  MockData.blankProfileAvatar,
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 4.0,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(8.0),
                                  bottomRight: Radius.circular(8.0),
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
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
