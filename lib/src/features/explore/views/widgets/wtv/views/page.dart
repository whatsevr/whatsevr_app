import 'dart:math';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:whatsevr_app/config/widgets/posts_frame/video.dart';

import '../../../../../../../config/api/response_model/recommendation_videos.dart';
import '../../../../../../../config/widgets/refresh_indicator.dart';
import '../../../../bloc/explore_bloc.dart';

class ExplorePageWtvPage extends StatelessWidget {
  const ExplorePageWtvPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ExploreBloc, ExploreState, List<RecommendedVideo>?>(
      selector: (ExploreState state) => state.recommendationVideos,
      builder: (BuildContext context, List<RecommendedVideo>? data) {
        return MyRefreshIndicator(
          onPullDown: () async {
            context.read<ExploreBloc>().add(ExploreInitialEvent());
            await Future<void>.delayed(const Duration(seconds: 2));
          },
          onScrollFinished: () async {
            await Future<void>.delayed(const Duration(seconds: 2));
          },
          child: Skeletonizer(
            enabled: data == null || data.isEmpty,
            child: ListView.separated(
              shrinkWrap: data == null || data.isEmpty,
              itemCount: data?.length ?? 3,
              separatorBuilder: (BuildContext context, int index) =>
                  const Gap(8),
              itemBuilder: (BuildContext context, int index) {
                if (data == null || data.isEmpty) return const VideoFrame();
                return VideoFrame(
                  avatarUrl: data[index].user?.profilePicture,
                  username: data[index].user?.userName,
                  title: data[index].title,
                  description: data[index].description,
                  videoUrl: data[index].videoUrl,
                  thumbnail: data[index].thumbnail,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
