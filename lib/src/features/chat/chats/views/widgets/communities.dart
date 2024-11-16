part of '../page.dart';

class _CommunitiesListView extends StatelessWidget {
  const _CommunitiesListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder < ChatBloc, ChatState >
    (
      builder: (context, state) {
        return Scaffold(
          body: ListView.separated(
            itemCount: state.communities.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemBuilder: (BuildContext context, int index) {
              final community = state.communities[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                      ExtendedNetworkImageProvider(community.profilePicture??MockData.blankCommunityAvatar),
                ),
                title: Text('${community.title}'),
                subtitle: Text(community.plainLastMessage??'Start Chat'),
                trailing:  Text('${GetTimeAgo.parse(community.lastMessageAt!, pattern: 'ddMMM')}'),
              );
            },
          ),
        );
      },
    );
  }
}
