import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';
import 'package:whatsevr_app/src/features/chats/bloc/chat_bloc.dart';

import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
import 'package:whatsevr_app/config/widgets/tab_bar.dart';
import 'package:whatsevr_app/config/widgets/textfield/animated_search_field.dart';
import 'package:whatsevr_app/src/features/chats/views/widgets/calls.dart';
import 'package:whatsevr_app/src/features/chats/views/widgets/chats.dart';
import 'package:whatsevr_app/src/features/chats/views/widgets/groups.dart';
import 'package:whatsevr_app/src/features/chats/views/widgets/requests.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(
        AuthUserDb.getLastLoggedUserUid()!,
      )..add(InitialEvent()),
      child: Column(
        children: <Widget>[
          PadHorizontal(
            child: WhatsevrAnimatedSearchField(
              hintTexts: const <String>[
                'Search for chats',
                'Search for messages',
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
