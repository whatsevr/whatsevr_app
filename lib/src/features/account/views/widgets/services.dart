import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/api/response_model/profile_details.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';
import 'package:whatsevr_app/config/widgets/buttons/button.dart';
import 'package:whatsevr_app/src/features/account/bloc/account_bloc.dart';
import 'package:whatsevr_app/src/features/update_user_profile/views/page.dart';

class AccountPageServicesView extends StatelessWidget {
  const AccountPageServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (BuildContext context, AccountState state) {
        if (state.profileDetailsResponse?.userServices?.isEmpty ?? true) {
          return SizedBox(
            height: 150,
            child: Center(
              child: WhatsevrButton.text(
                shrink: true,
                label: '+ Add Services',
                onPressed: () {
                  AppNavigationService.newRoute(
                    RoutesName.updateUserProfile,
                    extras: UserProfileUpdatePageArgument(
                      profileDetailsResponse: state.profileDetailsResponse,
                    ),
                  );
                },
              ),
            ),
          );
        }
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            final UserService? userService =
                state.profileDetailsResponse?.userServices?[index];
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
          itemCount: state.profileDetailsResponse?.userServices?.length ?? 0,
        );
      },
    );
  }
}
