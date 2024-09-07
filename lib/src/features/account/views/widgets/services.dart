import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:intl/intl.dart';
import 'package:whatsevr_app/config/api/response_model/profile_details.dart';
import 'package:colorful_iconify_flutter/icons/vscode_icons.dart';
import '../../bloc/account_bloc.dart';

class AccountPageServicesView extends StatelessWidget {
  const AccountPageServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        return ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            UserService? userService =
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
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Gap(8),
                      Text(
                        '${userService?.description}',
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
            return Divider();
          },
          itemCount: state.profileDetailsResponse?.userServices?.length ?? 0,
        );
      },
    );
  }
}
