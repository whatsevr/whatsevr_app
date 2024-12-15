import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/api/methods/chats.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';
import 'package:whatsevr_app/config/widgets/buttons/button.dart';
import 'package:whatsevr_app/config/widgets/dialogs/showAppModalSheet.dart';
import 'package:whatsevr_app/config/widgets/textfield/super_textform_field.dart';
import 'package:whatsevr_app/src/features/chat/conversation/views/page.dart';

void startChat({
  String? currentUserUid,
  String? otherUserUid,
  String? communityUid,
}) async {
  try {
    assert(
      (currentUserUid != null && otherUserUid != null) || communityUid != null,
      'Either provide both currentUserUid and otherUserUid or provide communityUid',
    );
    SmartDialog.showLoading(msg: 'Starting chat...');
    final (int? statusCode, String? message, String? privateChatUid)? response =
        await ChatsApi.startChat(
      currentUserUid: currentUserUid,
      otherUserUid: otherUserUid,
      communityUid: communityUid,
    );
    SmartDialog.dismiss();
    if (response?.$1 != HttpStatus.ok) {
      SmartDialog.showToast('${response?.$2}');
    }
    if (currentUserUid != null && otherUserUid != null) {
      if (response?.$3 != null) {
        AppNavigationService.newRoute(
          RoutesName.chatConversation,
          extras: ConversationPageArguments(
            isCommunity: false,
            privateChatUid: response?.$3,
          ),
        );
        return;
      }
      showAppModalSheet(child: _SendPrivateMessageUi(
      
        currentUserUid: currentUserUid,
        otherUserUid: otherUserUid,
      ));
    }
    if (communityUid != null) {
      AppNavigationService.newRoute(
        RoutesName.chatConversation,
        extras: ConversationPageArguments(
            isCommunity: true, communityUid: communityUid),
      );
    }
  } catch (e, s) {
    highLevelCatch(e, s);
  }
}

class _SendPrivateMessageUi extends StatelessWidget {
  final String?  currentUserUid;
  final String? otherUserUid;
  const _SendPrivateMessageUi({
    this.currentUserUid,
    this.otherUserUid,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WhatsevrFormField.multilineTextField(),
        WhatsevrButton.filled(label: 'Send Message'),
      ],
    );
  }
}
