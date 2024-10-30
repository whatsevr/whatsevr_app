import 'package:flutter/material.dart';

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
    return Column(
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
    );
  }
}
