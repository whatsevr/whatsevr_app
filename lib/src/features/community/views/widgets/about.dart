import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:whatsevr_app/config/themes/theme.dart';

import '../../../../../config/api/response_model/community/community_details.dart';
import '../../../../../utils/conversion.dart';
import '../../bloc/bloc.dart';

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
