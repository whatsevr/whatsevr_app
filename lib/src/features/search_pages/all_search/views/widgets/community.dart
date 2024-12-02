part of '../page.dart';

class _CommunityView extends StatelessWidget {
  _CommunityView();
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    onReachingEndOfTheList(
      _scrollController,
      execute: () {
        context.read<AllSearchBloc>().add(SearchMoreCommunities());
      },
    );
    return BlocBuilder<AllSearchBloc, AllSearchState>(
      builder: (context, state) {
        return ListView.separated(
          controller: _scrollController,
          shrinkWrap: true,
          itemCount: state.searchedCommunities?.communities?.length ?? 0,
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemBuilder: (BuildContext context, int index) {
            final community = state.searchedCommunities?.communities?[index];
            return InkWell(
              onTap: () {
                AppNavigationService.newRoute(
                  RoutesName.community,
                  extras: CommunityPageArgument(communityUid: community?.uid),
                );
              },
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      ExtendedImage.network(
                        MockData.imagePlaceholder('Cover Image'),
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                      if (community?.totalMembers != null &&
                          community?.totalMembers != 0)
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '${formatCountToKMBTQ(community?.totalMembers)} Members',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const Gap(8),
                  Row(
                    children: <Widget>[
                      const Gap(16),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey,
                        backgroundImage: ExtendedNetworkImageProvider(
                          community?.profilePicture ??
                              MockData.blankCommunityAvatar,
                        ),
                      ),
                      const Gap(16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${community?.title}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '@${community?.username}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(8),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
