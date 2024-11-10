part of '../page.dart';

class _PortfolioView extends StatelessWidget {
  _PortfolioView();
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    onReachingEndOfTheList(_scrollController, execute: () {
      context.read<AllSearchBloc>().add(SearchMorePortfolios());
    });
    return BlocBuilder<AllSearchBloc, AllSearchState>(
      builder: (context, state) {
        return ListView.separated(
          controller: _scrollController,
          shrinkWrap: true,
          itemCount: state.searchedPortfolios?.portfolios?.length ?? 0,
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemBuilder: (BuildContext context, int index) {
            final portfolio = state.searchedPortfolios?.portfolios?[index];
            return InkWell(
              onTap: () {
                AppNavigationService.newRoute(
                  RoutesName.account,
                  extras: AccountPageArgument(
                      isEditMode: false, userUid: portfolio?.uid),
                );
              },
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 16 / 6,
                        child: ExtendedImage.network(
                          MockData.imagePlaceholder('Cover Image'),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
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
                            '${portfolio?.portfolioStatus}',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
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
                          portfolio?.profilePicture ??
                              MockData.randomImageAvatar(),
                        ),
                      ),
                      const Gap(16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${portfolio?.name}',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              '${portfolio?.username}',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                      const Gap(8),
                      WhatsevrFollowButton(
                        followeeUserUid: portfolio?.uid,
                        filledButton: false,
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
