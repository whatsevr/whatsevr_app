import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/widgets/posts_frame/video.dart';

class ExplorePageWtvPage extends StatelessWidget {
  const ExplorePageWtvPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 20,
      separatorBuilder: (BuildContext context, int index) => const Gap(8),
      itemBuilder: (BuildContext context, int index) {
        return const VideoFrame();
      },
    );
  }
}
