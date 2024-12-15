part of '../page.dart';

class _ChatListView extends StatelessWidget {
  const _ChatListView();

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
                dense: true,
                visualDensity: VisualDensity.compact,
                onTap: () {
                  AppNavigationService.newRoute(
                    RoutesName.chatConversation,
                    extras: ConversationsPage(
                      pageArguments: ConversationPageArguments(
                        isCommunity: false,
                        privateChatUid: chat.uid,
                        title: otherUser?.name,
                        profilePicture: otherUser?.profilePicture,
                      ),
                    ),
                  );
                },
                leading: CircleAvatar(
                  backgroundImage: ExtendedNetworkImageProvider(
                    otherUser?.profilePicture ?? MockData.blankProfileAvatar,
                  ),
                ),
                title: Text(
                  '${otherUser?.name}',
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                subtitle: Text(
                  chat.plainLastMessage ?? 'Start Chat',
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
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
