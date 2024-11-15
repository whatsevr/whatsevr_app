import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';
import 'package:whatsevr_app/src/features/chats/bloc/chat_bloc.dart';

import '../../../../config/widgets/pad_horizontal.dart';
import '../../../../config/widgets/tab_bar.dart';
import '../../../../config/widgets/textfield/animated_search_field.dart';
import 'widgets/calls.dart';
import 'widgets/chats.dart';
import 'widgets/groups.dart';
import 'widgets/requests.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(
        AuthUserDb.getLastLoggedUserUid()!,
      ),
      child: Column(
        children: <Widget>[
          PadHorizontal(
            child: WhatsevrAnimatedSearchField(
              hintTexts: const <String>[
                'Search for chats',
                'Search for communities',
                'Search for calls',
                'Search for requests',
              ],
            ),
          ),
          const Expanded(
            child: WhatsevrTabBarWithViews(
              tabViews: [
                ('Chats', ChatsPageChatsView()),
                ('Communities', ChatsPageGroupsView()),
                ('Contacts', ChatsPageCallsView()),
                ('Requests', ChatsPageRequestsView()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
