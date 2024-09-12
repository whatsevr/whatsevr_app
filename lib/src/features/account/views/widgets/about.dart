import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:whatsevr_app/src/features/account/bloc/account_bloc.dart';
import 'package:whatsevr_app/utils/conversion.dart';

import 'package:whatsevr_app/config/api/response_model/profile_details.dart';

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
                true) ...<Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Gap(8),
                        Text(
                          'Status',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          '${state.profileDetailsResponse?.userInfo?.portfolioStatus}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gap(8),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Gap(8),
                        Row(
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
                              'View More>>',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.blue),
                            ),
                          ],
                        ),
                        Wrap(
                          spacing: 8,
                          children: <Widget>[
                            for (UserService? service
                                in state.profileDetailsResponse?.userServices ??
                                    <UserService?>[])
                              ActionChip(
                                backgroundColor: Colors.blueGrey,
                                label: Text(
                                  '${service?.title}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                onPressed: () {},
                              ),
                          ],
                        ),
                        Gap(8),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            for ((String label, String info) itm in <(String, String)>[
              ('Bio', '${state.profileDetailsResponse?.userInfo?.bio}'),
              ('Address', '${state.profileDetailsResponse?.userInfo?.address}'),
              (
                'Education',
                '${state.profileDetailsResponse?.userEducations?.map((UserEducation? e) => '${e?.title} (${DateFormat('yyyy').format(e!.endDate!)})').join(', ')}',
              ),
              (
                'Working Experience',
                '${state.profileDetailsResponse?.userWorkExperiences?.map((UserWorkExperience? e) => '${e?.companyName} - ${e?.designation} (${DateFormat('yyyy').format(e!.endDate!)})').join(', ')}',
              ),
              ('Email', '${state.profileDetailsResponse?.userInfo?.emailId}'),
              if (state.profileDetailsResponse?.userInfo?.dob != null)
                (
                  'Birthday',
                  '${DateFormat('dd MMM,yyyy').format(state.profileDetailsResponse!.userInfo!.dob!)} (Age: ${calculateAge(state.profileDetailsResponse!.userInfo!.dob!)})',
                ),
              if (state.profileDetailsResponse?.userInfo?.registeredOn != null)
                (
                  'Join On',
                  (DateFormat('hh:mm a, dd MMM,yyyy').format(
                      state.profileDetailsResponse!.userInfo!.registeredOn!))
                ),
              (
                state.profileDetailsResponse?.userInfo?.isPortfolio == true
                    ? 'Portfolio link'
                    : 'Account link',
                'https://app.whatsevr.com/${state.profileDetailsResponse?.userInfo?.userName}'
              ),
              if (state.profileDetailsResponse?.userInfo?.portfolioCreatedAt !=
                  null)
                (
                  'Portfolio Created On',
                  (DateFormat('hh:mm a, dd MMM,yyyy').format(state
                      .profileDetailsResponse!.userInfo!.portfolioCreatedAt!))
                ),
              (
                'Description',
                '${state.profileDetailsResponse?.userInfo?.portfolioDescription}'
              ),
              ('Total Connection', '3636'),
              ('Total Post', '2524'),
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
