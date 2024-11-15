import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get_time_ago/get_time_ago.dart';

import 'package:whatsevr_app/config/api/response_model/post_details/video.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
import 'package:whatsevr_app/utils/conversion.dart';
import 'package:whatsevr_app/src/features/details/wtv_details/bloc/wtv_details_bloc.dart';

class WtvVideoDetailsRelatedVideosView extends StatelessWidget {
  const WtvVideoDetailsRelatedVideosView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WtvDetailsBloc, WtvDetailsState>(
      builder: (context, state) {
        return ListView.separated(
          itemCount:
              state.videoPostDetailsResponse?.relatedVideoPosts?.length ?? 0,
          padding: PadHorizontal.padding,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            final RelatedVideoPost? relatedVideoPost =
                state.videoPostDetailsResponse?.relatedVideoPosts?[index];
            return GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  context.read<WtvDetailsBloc>().add(
                        FetchVideoPostDetails(
                          videoPostUid: relatedVideoPost.uid,
                          thumbnail: relatedVideoPost.thumbnail,
                          videoUrl: relatedVideoPost.videoUrl,
                        ),
                      );
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        ExtendedImage.network(
                          relatedVideoPost?.thumbnail ??
                              MockData.imagePlaceholder(),
                          borderRadius: BorderRadius.circular(8),
                          shape: BoxShape.rectangle,
                          fit: BoxFit.cover,
                          height: 120,
                          width: 180,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '${getDurationInText(relatedVideoPost?.videoDurationInSec)}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <StatelessWidget>[
                          Text(
                            '${relatedVideoPost?.title}',
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold,),
                          ),
                          Gap(8),
                          Text(
                            '${formatCountToKMBTQ(relatedVideoPost?.totalViews)} views · ${GetTimeAgo.parse(relatedVideoPost!.createdAt!)}',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Gap(8);
          },
        );
      },
    );
  }
}
