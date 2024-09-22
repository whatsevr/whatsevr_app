import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/api/response_model/profile_details.dart';

import 'package:whatsevr_app/src/features/account/bloc/account_bloc.dart';

class AccountPageVideosView extends StatelessWidget {
  const AccountPageVideosView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (BuildContext context, AccountState state) {
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            UserVideoPost? userVideoPost =
                state.profileDetailsResponse?.userVideoPosts?[index];
            return Row(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    ExtendedImage.network(
                      '${userVideoPost?.thumbnail}',
                      borderRadius: BorderRadius.circular(8),
                      shape: BoxShape.rectangle,
                      fit: BoxFit.cover,
                      height: 100,
                      width: 150,
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
                        child: const Text(
                          '10:00',
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
                        '${userVideoPost?.title}',
                        maxLines: 2,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold,),
                      ),
                      const Gap(8),
                      const Text(
                        '2M views . 2 days ago . 122k likes',
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
          separatorBuilder: (BuildContext context, int index) {
            return const Gap(8);
          },
          itemCount: state.profileDetailsResponse?.userVideoPosts?.length ?? 0,
        );
      },
    );
  }
}
