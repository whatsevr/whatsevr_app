part of 'package:whatsevr_app/src/features/settings/views/page.dart';

class _YourCommunities extends StatelessWidget {
  const _YourCommunities();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your communities',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(8),
            SizedBox(
              height: 100,
              child: Builder(
                builder: (BuildContext context) {
                  final List<Widget> children = <Widget>[
                    //create community
                    Column(
                      children: [
                        GestureDetector(
                            onTap: () {
                              AppNavigationService.newRoute(
                                  RoutesName.newCommunity,
                                  extras: NewCommunityPageArgument(),);
                            },
                            child: CircleAvatar(
                              radius: 30,
                              child: Icon(Icons.add),
                            ),),
                      ],
                    ),
                    for (Community? userCommunity
                        in state.userCommunitiesResponse?.userCommunities ?? [])
                      Column(
                        children: <Widget>[
                          AdvancedAvatar(
                            size: 62,
                            image: ExtendedNetworkImageProvider(
                              userCommunity?.profilePicture ??
                                  MockData.blankProfileAvatar,
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
                                    size: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Gap(8),
                          SizedBox(
                            width: 60,
                            child: Text(
                              '${userCommunity?.title}',
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (state.userCommunitiesResponse?.joinedCommunities
                            ?.isNotEmpty ??
                        false)
                      VerticalDivider(
                        color: Colors.grey,
                        width: 8,
                        thickness: 0.5,
                        endIndent: 44,
                        indent: 8,
                      ),
                    for (Community? joinedCommunity
                        in state.userCommunitiesResponse?.joinedCommunities ??
                            [])
                      Column(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: ExtendedNetworkImageProvider(
                              joinedCommunity?.profilePicture ??
                                  MockData.blankProfileAvatar,
                            ),
                            radius: 30,
                          ),
                          const Gap(8),
                          SizedBox(
                            width: 60,
                            child: Text(
                              '${joinedCommunity?.title}',
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ];
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return ZoomIn(child: children[index]);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Gap(8);
                    },
                    itemCount: children.length,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
