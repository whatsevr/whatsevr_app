import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../config/api/response_model/user_offers.dart';
import '../../../../../utils/conversion.dart';
import '../../bloc/account_bloc.dart';

class AccountPageOffersView extends StatelessWidget {
  const AccountPageOffersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (BuildContext context, AccountState state) {
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (BuildContext context, int index) {
            return const Gap(4);
          },
          itemCount: state.userOffers.length,
          itemBuilder: (BuildContext context, int index) {
            final OfferPost? userOfferPost = state.userOffers[index];
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey[300]!,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${userOfferPost?.status}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Gap(4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              '${userOfferPost?.title}',
                              maxLines: 2,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          ...[
                            const Gap(4),
                            Icon(Icons.more_horiz),
                          ],
                        ],
                      ),
                      if (userOfferPost?.filesData?.isEmpty ?? true) ...[
                        const Gap(4),
                        Text(
                          '${userOfferPost?.description}',
                          maxLines: 8,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (userOfferPost?.filesData?.isNotEmpty ?? false) ...[
                    const Gap(8),
                    SizedBox(
                      height: 120,
                      child: ListView.separated(
                        itemCount: userOfferPost?.filesData?.length ?? 0,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (BuildContext context, int index) {
                          return const Gap(8);
                        },
                        itemBuilder: (BuildContext context, int index) {
                          final FilesDatum? fileData =
                              userOfferPost?.filesData?[index];
                          if (fileData?.type == 'image' ||
                              fileData?.type == 'video') {
                            return ExtendedImage.network(
                              fileData?.imageUrl ??
                                  fileData?.videoThumbnailUrl ??
                                  '',
                              fit: BoxFit.cover,
                              enableLoadState: false,
                              cache: true,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(8),
                            );
                          } else {
                            return SizedBox();
                          }
                        },
                      ),
                    ),
                  ],
                  const Gap(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for ((String? value, IconData? icon) record in [
                        (
                          '${formatCountToKMBTQ(userOfferPost?.totalImpressions)}',
                          Icons.remove_red_eye,
                        ),
                        (
                          '${formatCountToKMBTQ(userOfferPost?.totalLikes)}',
                          Icons.thumb_up_sharp,
                        ),
                        (
                          '${formatCountToKMBTQ(userOfferPost?.totalComments)}',
                          Icons.comment,
                        ),
                        (
                          '${formatCountToKMBTQ(userOfferPost?.totalShares)}',
                          Icons.share_sharp,
                        ),
                      ])
                        Row(
                          children: [
                            Text(
                              '${record.$1}',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Gap(4),
                            Icon(
                              record.$2,
                              size: 16,
                            ),
                            const Gap(8),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
