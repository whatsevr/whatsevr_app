import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';
import 'package:whatsevr_app/config/themes/theme.dart';
import 'package:whatsevr_app/src/features/chat/chats/bloc/chat_bloc.dart';
import 'package:extended_image/extended_image.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/src/features/chat/conversation/views/page.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
import 'package:whatsevr_app/config/widgets/tab_bar.dart';
import 'package:whatsevr_app/config/widgets/textfield/animated_search_field.dart';
import 'package:whatsevr_app/src/features/chat/chats/views/widgets/calls.dart';

import 'package:whatsevr_app/src/features/chat/chats/views/widgets/requests.dart';
part 'widgets/chats.dart';
part 'widgets/communities.dart';

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
                ('Chats', _ChatListView()),
                ('Communities', _CommunitiesListView()),
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
