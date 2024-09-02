import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/src/features/chats/views/widgets/calls.dart';
import 'package:whatsevr_app/src/features/chats/views/widgets/chats.dart';
import 'package:whatsevr_app/src/features/chats/views/widgets/groups.dart';
import 'package:whatsevr_app/src/features/chats/views/widgets/requests.dart';

import '../../../../config/widgets/animated_search_field.dart';
import '../../../../config/widgets/pad_horizontal.dart';
import '../../../../config/widgets/tab_bar.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PadHorizontal(
          child: WhatsevrAnimatedSearchField(
            hintTexts: const [
              'Search for chats',
              'Search for groups',
              'Search for calls',
              'Search for requests',
            ],
          ),
        ),
        const Expanded(
          child: WhatsevrTabBarWithViews(
            tabs: [
              'Chats',
              'Groups',
              'Calls',
              'Requests',
            ],
            tabViews: [
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








