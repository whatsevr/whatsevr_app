import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/api/response_model/community/community_details.dart';

import 'package:whatsevr_app/src/features/community/bloc/bloc.dart';

class CommunityPageServicesView extends StatelessWidget {
  const CommunityPageServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityBloc, CommunityState>(
      builder: (BuildContext context, CommunityState state) {
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            final CommunityService? userService =
                state.communityDetailsResponse?.communityServices?[index];
            return Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <StatelessWidget>[
                      Text(
                        '${userService?.title}',
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(8),
                      Text(
                        '${userService?.description}',
                        style: const TextStyle(
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
            return const Divider();
          },
          itemCount:
              state.communityDetailsResponse?.communityServices?.length ?? 0,
        );
      },
    );
  }
}
