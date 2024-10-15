import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/api/response_model/user_flicks.dart';

import 'package:whatsevr_app/src/features/account/bloc/account_bloc.dart';

import '../../../../../utils/conversion.dart';

class AccountPageFlicksView extends StatelessWidget {
  const AccountPageFlicksView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (BuildContext context, AccountState state) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 9 / 21,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: state.userFlicks.length,
          itemBuilder: (BuildContext context, int index) {
            Flick? userVideoPost = state.userFlicks[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 9 / 16,
                  child: Stack(
                    children: <Widget>[
                      ExtendedImage.network(
                        '${userVideoPost?.thumbnail}',
                        borderRadius: BorderRadius.circular(8),
                        shape: BoxShape.rectangle,
                        fit: BoxFit.cover,
                        enableLoadState: false,
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '${getDurationInText(userVideoPost?.videoDurationInSec)}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 2,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              Text(
                                '${formatCountToKMBTQ(userVideoPost?.totalViews)}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              Gap(4),
                              const Icon(
                                Icons.remove_red_eye,
                                color: Colors.white,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              '${userVideoPost?.title}',
                              maxLines: 3,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          ...[
                            const Gap(4),
                            Icon(Icons.more_horiz),
                          ]
                        ],
                      ),
                      Text(
                        '${formatCountToKMBTQ(userVideoPost?.totalLikes)} likes • ${formatCountToKMBTQ(userVideoPost?.totalComments)} comments',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '${formatCountToKMBTQ(userVideoPost?.totalShares)} shares • ${(userVideoPost?.taggedUserUids?.length ?? 0) + (userVideoPost?.taggedCommunityUids?.length ?? 0)} tagged',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '${ddMonthyy(userVideoPost?.createdAt)}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
