import 'package:flutter/material.dart';
import 'package:whatsevr_app/src/features/chats/views/widgets/calls.dart';
import 'package:whatsevr_app/src/features/chats/views/widgets/chats.dart';
import 'package:whatsevr_app/src/features/chats/views/widgets/groups.dart';
import 'package:whatsevr_app/src/features/chats/views/widgets/requests.dart';

import 'package:whatsevr_app/config/widgets/animated_search_field.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
import 'package:whatsevr_app/config/widgets/tab_bar.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        PadHorizontal(
          child: WhatsevrAnimatedSearchField(
            hintTexts: const <String>[
              'Search for chats',
              'Search for groups',
              'Search for calls',
              'Search for requests',
            ],
          ),
        ),
        const Expanded(
          child: WhatsevrTabBarWithViews(
            tabs: <String>[
              'Chats',
              'Groups',
              'Calls',
              'Requests',
            ],
            tabViews: <Widget>[
              ChatsPageChatsView(),
              ChatsPageGroupsView(),
              ChatsPageCallsView(),
              ChatsPageRequestsView(),
            ],
          ),
        ),
      ],
    );
  }
}








