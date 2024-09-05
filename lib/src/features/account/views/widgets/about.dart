import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:whatsevr_app/src/features/account/bloc/account_bloc.dart';
import 'package:whatsevr_app/utils/conversion.dart';

class AccountPageAboutView extends StatelessWidget {
  const AccountPageAboutView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        return Column(
          children: <Widget>[
            const Gap(12),
            if (state.profileDetailsResponse?.userInfo?.isPortfolio ==
                true) ...[
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
                              fontSize: 16, fontWeight: FontWeight.bold),
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
                          children: [
                            Text(
                              'Serve',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'View More>>',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.blue),
                            ),
                          ],
                        ),
                        // ListView.separated(
                        //   shrinkWrap: true,
                        //   physics: const NeverScrollableScrollPhysics(),
                        //   itemBuilder: (BuildContext context, int index) {
                        //     return Chip(label: Text("wetrt4363543"));
                        //   },
                        //   separatorBuilder: (BuildContext context, int index) {
                        //     return const Gap(8);
                        //   },
                        //   itemCount: 5,
                        // ),
                        Wrap(
                          spacing: 8,
                          children: <Widget>[
                            for (String tag in ['2525235435', '252424324235'])
                              ActionChip(
                                backgroundColor: Colors.blueGrey,
                                label: Text(tag,
                                    style:
                                        const TextStyle(color: Colors.white)),
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
              ('Education', ''),
              ('Working', ''),
              ('Email', '${state.profileDetailsResponse?.userInfo?.emailId}'),
              if (state.profileDetailsResponse?.userInfo?.dob != null)
                (
                  'Birthday',
                  '${DateFormat('dd MMM,yyyy').format(state.profileDetailsResponse!.userInfo!.dob!)} (Age: ${calculateAge(state.profileDetailsResponse!.userInfo!.dob!)})',
                ),
              if (state.profileDetailsResponse?.userInfo?.registeredOn != null)
                (
                  'Join On',
                  '${DateFormat('hh:mm a, dd MMM,yyyy').format(state.profileDetailsResponse!.userInfo!.registeredOn!)}'
                ),
              ('Account link', ''),
              if (state.profileDetailsResponse?.userInfo?.portfolioCreatedAt !=
                  null)
                (
                  'Portfolio Created On',
                  '${DateFormat('hh:mm a, dd MMM,yyyy').format(state.profileDetailsResponse!.userInfo!.portfolioCreatedAt!)}'
                ),
              ('About', ''),
              ('Total Connection', ''),
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
