part of '../page.dart';

class _AccountsView extends StatelessWidget {
  _AccountsView();
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    onReachingEndOfTheList(_scrollController, execute: () {
      context.read<AllSearchBloc>().add(SearchMoreUsers());
    });
    return BlocBuilder<AllSearchBloc, AllSearchState>(
      builder: (context, state) {
        return ListView.separated(
          controller: _scrollController,
          shrinkWrap: true,
          padding: PadHorizontal.padding,
          itemCount: state.searchedUsers?.users?.length ?? 0,
          separatorBuilder: (BuildContext context, int index) => const Gap(2),
          itemBuilder: (BuildContext context, int index) {
            final user = state.searchedUsers?.users?[index];
            return Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey,
                      backgroundImage: ExtendedNetworkImageProvider(
                        user?.profilePicture ?? MockData.blankProfileAvatar,
                      ),
                    ),
                    const Gap(16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${user?.name}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '@${user?.username}',
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(8),
                    MaterialButton(
                      visualDensity: VisualDensity.compact,
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: const Text('Add Friend'),
                    ),
                    const Gap(8),
                  ],
                ),
                Row(
                  children: <Widget>[
                    const Gap(8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              children: <InlineSpan>[
                                if (user?.bio != null && user!.bio!.isNotEmpty)
                                  TextSpan(
                                    text: 'Bio\n',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: '${user.bio}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                if (user?.address != null &&
                                    user!.address!.isNotEmpty)
                                  TextSpan(
                                    text: '\nAddress:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: '${user?.address}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
