import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:whatsevr_app/config/themes/theme.dart';

import 'package:whatsevr_app/config/api/response_model/profile_details.dart';
import 'package:whatsevr_app/utils/conversion.dart';
import 'package:whatsevr_app/src/features/account/bloc/account_bloc.dart';

class AccountPageAboutView extends StatelessWidget {
  const AccountPageAboutView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (BuildContext context, AccountState state) {
        return Column(
          children: <Widget>[
            const Gap(12),
            if (state.profileDetailsResponse?.userInfo?.isPortfolio ==
                true  
                ) ...<Widget>[
                  if(state.profileDetailsResponse?.userInfo?.portfolioStatus?.isNotEmpty??false)
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
                          '${state.profileDetailsResponse?.userInfo?.portfolioStatus}',
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
              if( state.profileDetailsResponse?.userServices?.isNotEmpty??false)
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
                          children: <Widget>[
                            for (UserService? service
                                in state.profileDetailsResponse?.userServices ??
                                    <UserService?>[])
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
              if (state.profileDetailsResponse?.userInfo?.bio?.isNotEmpty ??
                  false)
                ('Bio', '${state.profileDetailsResponse?.userInfo?.bio}'),
              if (state.profileDetailsResponse?.userInfo?.address?.isNotEmpty ??
                  false)
                (
                  'Address',
                  '${state.profileDetailsResponse?.userInfo?.address}'
                ),
              if (state.profileDetailsResponse?.userEducations?.isNotEmpty ??
                  false)
                (
                  'Education',
                  '${state.profileDetailsResponse?.userEducations?.map((UserEducation? e) => '${e?.title} (${DateFormat('yyyy').format(e!.endDate!)})').join(', ')}',
                ),
              if (state.profileDetailsResponse?.userWorkExperiences
                      ?.isNotEmpty ??
                  false)
                (
                  'Working Experience',
                  '${state.profileDetailsResponse?.userWorkExperiences?.map((UserWorkExperience? e) => '${e?.companyName} - ${e?.designation} (${DateFormat('yyyy').format(e!.endDate!)})').join(', ')}',
                ),
              if (state.profileDetailsResponse?.userInfo?.publicEmailId
                      ?.isNotEmpty ??
                  false)
                (
                  'Email',
                  (state.profileDetailsResponse?.userInfo?.publicEmailId ?? '')
                ),
              if (state.profileDetailsResponse?.userInfo?.dob != null)
                (
                  'Birthday',
                  '${DateFormat('dd MMM,yyyy').format(state.profileDetailsResponse!.userInfo!.dob!)} (Age: ${calculateAgeInYearsAndMonth(state.profileDetailsResponse!.userInfo!.dob!)})',
                ),
              if (state.profileDetailsResponse?.userInfo?.registeredOn != null)
                (
                  'Join On',
                  '${ddMonthyy(state.profileDetailsResponse?.userInfo?.registeredOn)}'
                ),
              (
                state.profileDetailsResponse?.userInfo?.isPortfolio == true
                    ? 'Portfolio link'
                    : 'Account link',
                'https://app.whatsevr.com/${state.profileDetailsResponse?.userInfo?.username}'
              ),
              if (state.profileDetailsResponse?.userInfo?.isPortfolio == true &&
                  state.profileDetailsResponse?.userInfo?.portfolioCreatedAt !=
                      null)
                (
                  'Portfolio Created On',
                  '${ddMonthyy(state.profileDetailsResponse?.userInfo?.portfolioCreatedAt)}'
                ),
              if (state.profileDetailsResponse?.userInfo?.portfolioDescription
                      ?.isNotEmpty ??
                  false)
                (
                  'Description',
                  '${state.profileDetailsResponse?.userInfo?.portfolioDescription}'
                ),
              (
                'Total Connection',
                '${formatCountToKMBTQ(state.profileDetailsResponse?.userInfo?.totalConnections)}'
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
