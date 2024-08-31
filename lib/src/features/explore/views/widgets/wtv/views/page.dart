import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/widgets/posts_frame/video.dart';

import '../../../../../../../config/api/models/recommendation_videos.dart';
import '../../../../bloc/explore_bloc.dart';

class ExplorePageWtvPage extends StatelessWidget {
  const ExplorePageWtvPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ExploreBloc, ExploreState, List<RecommendationVideo>?>(
      selector: (ExploreState state) => state.recommendationVideos,
      builder: (BuildContext context, List<RecommendationVideo>? data) {
        return ListView.separated(
          shrinkWrap: true,
          itemCount: data?.length ?? 0,
          separatorBuilder: (BuildContext context, int index) => const Gap(8),
          itemBuilder: (BuildContext context, int index) {
            return VideoFrame(
              avatarUrl: data?[index].userInfo?.profilePicture,
              username: data?[index].userInfo?.userName,
              title: data?[index].title,
              description: data?[index].description,
              videoUrl: data?[index].video?.mediaUrl,
              thumbnail: data?[index].video?.thumbnail,
            );
          },
        );
      },
    );
  }
}
