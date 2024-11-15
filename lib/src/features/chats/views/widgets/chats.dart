import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:whatsevr_app/src/features/chats/bloc/chat_bloc.dart';
import '../../../../../config/mocks/mocks.dart';

class ChatsPageChatsView extends StatelessWidget {
  const ChatsPageChatsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        return Scaffold(
          body: ListView.separated(
            itemCount: state.privateChats.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemBuilder: (BuildContext context, int index) {
              final chat = state.privateChats[index];
              final otherUser = context
                  .read<ChatBloc>()
                  .getTheOtherUser(chat.user1, chat.user2);
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: ExtendedNetworkImageProvider(
                      otherUser?.profilePicture ?? MockData.blankProfileAvatar),
                ),
                title: Text(
                  ' ${otherUser?.name}',
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  'XXXXXXXXXXXX',
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
                trailing: Text(
                  ' ${GetTimeAgo.parse(
                    chat.lastMessageAt!,
                    pattern: 'ddMMM',
                  )}',
                ),
              );
            },
          ),
        );
      },
    );
  }
}
