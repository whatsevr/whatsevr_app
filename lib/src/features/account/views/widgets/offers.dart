import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/api/response_model/user_offers.dart';

import 'package:whatsevr_app/src/features/account/bloc/account_bloc.dart';

import '../../../../../utils/conversion.dart';

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
            OfferPost? userOfferPost = state.userOffers[index];
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
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
                          ]
                        ],
                      ),
                      const Gap(4),
                      Text(
                        '${userOfferPost?.description}',
                        maxLines: 5,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  if (userOfferPost?.filesData?.isNotEmpty ?? false) ...[
                    const Gap(8),
                    SizedBox(
                      height: 100,
                      child: ListView.separated(
                        itemCount: userOfferPost?.filesData?.length ?? 0,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (BuildContext context, int index) {
                          return const Gap(8);
                        },
                        itemBuilder: (BuildContext context, int index) {
                          FilesDatum? fileData =
                              userOfferPost?.filesData?[index];
                          if (fileData?.type == 'image') {
                            return Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ExtendedImage.network(
                                fileData?.imageUrl ?? '',
                                fit: BoxFit.cover,
                                cache: true,
                              ),
                            );
                          } else if (fileData?.type == 'video') {
                            return Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ExtendedImage.network(
                                fileData?.videoThumbnailUrl ?? '',
                                fit: BoxFit.cover,
                                cache: true,
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                        },
                      ),
                    ),
                  ],
                  const Gap(8),
                  Row(
                    children: [
                      Text(
                        '${formatCountToKMBTQ(userOfferPost?.totalImpressions)}',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Gap(4),
                      const Icon(
                        Icons.remove_red_eye,
                        size: 16,
                      ),
                      const Gap(8),
                      Text(
                        '${ddMonthyy(userOfferPost?.createdAt)}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                        ),
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
