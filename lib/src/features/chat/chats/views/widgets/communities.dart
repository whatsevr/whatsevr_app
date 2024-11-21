part of '../page.dart';

class _CommunitiesListView extends StatelessWidget {
  const _CommunitiesListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        return Scaffold(
          body: ListView.separated(
            itemCount: state.communities.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemBuilder: (BuildContext context, int index) {
              final community = state.communities[index];
              return ListTile(
                onTap: () {
                  AppNavigationService.pushPage(
                      screen: ConversationsPage(
                    pageArguments: ConversationPageArguments(
                      isCommunity: true,
                      communityUid: community.uid,
                      title: community.title,
                      profilePicture: community.profilePicture ?? '',
                    ),
                  ));
                },
                leading: AdvancedAvatar(
                  decoration: BoxDecoration(
                    color: context.whatsevrTheme.shadow,
                    shape: BoxShape.circle,
                  ),
                  image: ExtendedNetworkImageProvider(
                    community.profilePicture ?? MockData.blankCommunityAvatar,
                    cache: true,
                  ),
                  children: [
                    Positioned(
                      right: 2,
                      bottom: 2,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                title: Text('${community.title}'),
                subtitle: Text(community.plainLastMessage ?? 'Start Chat'),
                trailing: community.lastMessageAt == null
                    ? null
                    :
                Text(
                    '${GetTimeAgo.parse(community.lastMessageAt!, pattern: 'ddMMM')}'),
              );
            },
          ),
        );
      },
    );
  }
}
