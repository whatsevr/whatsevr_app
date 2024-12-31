import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/api/response_model/community/community_details.dart';
import 'package:whatsevr_app/config/themes/theme.dart';

import 'package:whatsevr_app/utils/conversion.dart';
import 'package:whatsevr_app/src/features/community/bloc/bloc.dart';

class CommunityPageAboutView extends StatelessWidget {
  const CommunityPageAboutView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityBloc, CommunityState>(
      builder: (BuildContext context, CommunityState state) {
        return Column(
          children: <Widget>[
            const Gap(12),
            ...<Widget>[
              if (state.communityDetailsResponse?.communityInfo?.status
                      ?.isNotEmpty ??
                  false)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: context.whatsevrTheme.surface,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Gap(8),
                          const Text(
                            'Status',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            '${state.communityDetailsResponse?.communityInfo?.status}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(8),
                        ],
                      ),
                    ),
                  ),
                ),
              if (state.communityDetailsResponse?.communityServices
                      ?.isNotEmpty ??
                  false)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: context.whatsevrTheme.surface,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Gap(8),
                          const Row(
                            children: <StatelessWidget>[
                              Text(
                                'Serve',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              Spacer(),
                              Text(
                                'All Services>>',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.blue),
                              ),
                            ],
                          ),
                          Gap(8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: <Widget>[
                              for (CommunityService? service in state
                                      .communityDetailsResponse
                                      ?.communityServices ??
                                  <CommunityService?>[])
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    '${service?.title}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                            ],
                          ),
                          const Gap(8),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
            for ((String label, String info) itm in <(String, String)>[
              if (state.communityDetailsResponse?.communityInfo?.bio
                      ?.isNotEmpty ??
                  false)
                (
                  'Bio',
                  '${state.communityDetailsResponse?.communityInfo?.bio}'
                ),
              if (state.communityDetailsResponse?.communityInfo?.location
                      ?.isNotEmpty ??
                  false)
                (
                  'Address',
                  '${state.communityDetailsResponse?.communityInfo?.location}'
                ),
              if (state.communityDetailsResponse?.communityInfo?.createdAt !=
                  null)
                (
                  'Created On',
                  '${ddMonthyy(state.communityDetailsResponse?.communityInfo?.createdAt)}'
                ),
              ('Total Post', '0'),
              if (state.communityDetailsResponse?.communityInfo?.description !=
                  null)
                (
                  'Description',
                  '${state.communityDetailsResponse?.communityInfo?.description}'
                ),
            ])
              ListTile(
                visualDensity: VisualDensity.compact,
                title: Text(
                  itm.$1,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                subtitle: Text(
                  itm.$2,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                isThreeLine: true,
              ),
          ],
        );
      },
    );
  }
}
