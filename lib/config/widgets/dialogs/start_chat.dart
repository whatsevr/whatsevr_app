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
  String? senderUserUid,
  String? otherUserUid,
  String? communityUid,
}) async {
  try { 
    assert(
      (senderUserUid != null && otherUserUid != null) || communityUid != null,
      'Either provide both currentUserUid and otherUserUid or provide communityUid',
    );
    SmartDialog.showLoading(msg: 'Starting chat...');
    final (int? statusCode, String? message, String? privateChatUid)? response =
        await ChatsApi.startChat(
      currentUserUid: senderUserUid,
      otherUserUid: otherUserUid,
      communityUid: communityUid,
    );
    SmartDialog.dismiss();
    if (response?.$1 != HttpStatus.ok) {
      SmartDialog.showToast('${response?.$2}');
    }
    if (senderUserUid != null && otherUserUid != null) {
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
      showAppModalSheet(
          flexibleSheet: false,
          child: _SendPrivateMessageUi(
            currentUserUid: senderUserUid,
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
  final String? currentUserUid;
  final String? otherUserUid;
  _SendPrivateMessageUi({
    this.currentUserUid,
    this.otherUserUid,
    super.key,
  });
  final TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        WhatsevrFormField.multilineTextField(
          controller: messageController,
          minLines: 1,
        ),
        WhatsevrButton.filled(
          label: 'Send Message',
          onPressed: () async {
            SmartDialog.showLoading(msg: 'Sending message...');
            final (
              int? statusCode,
              String? message,
              String? privateChatUid
            )? response = await ChatsApi.startChat(
              currentUserUid: currentUserUid,
              otherUserUid: otherUserUid,
              message: messageController.text.trim(),
            );
            SmartDialog.dismiss();
            if (response?.$1 != HttpStatus.ok) {
              SmartDialog.showToast('${response?.$2}');
              return;
            }
            if (response?.$3 != null) {
              AppNavigationService.newRoute(
                RoutesName.chatConversation,
                extras: ConversationPageArguments(
                  isCommunity: false,
                  privateChatUid: response?.$3,
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
