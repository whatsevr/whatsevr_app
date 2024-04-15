import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/widgets/tab_bar.dart';

import '../../../../../config/routes/routes_name.dart';
import '../../../../../config/widgets/animated_search_field.dart';

class AccountSearchPage extends StatelessWidget {
  final List<String>? hintTexts;
  const AccountSearchPage({
    super.key,
    this.hintTexts,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: WhatsevrAnimatedSearchField(
              hintTexts: hintTexts ?? [],
              showBackButton: true,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: WhatsevrTabBarWithViews(
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              tabs: const [
                'Recents',
                'Accounts',
                'Portfolio',
                'Community',
                'Offers',
              ],
              tabViews: [
                _RecentView(),
                _AccountsView(),
                _PortfolioView(),
                _CommunityView(),
                _OffersView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OffersView extends StatelessWidget {
  const _OffersView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 20,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        return Column(
          children: [
            Row(
              children: [
                Gap(16),
                CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey,
                    backgroundImage: ExtendedNetworkImageProvider(
                      MockData.randomImageAvatar(),
                    )),
                Gap(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Username',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        'Location',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Gap(8),
            Stack(
              children: [
                ExtendedImage.network(
                  MockData.randomImageAvatar(),
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
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
                      'Freelancer',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
              ],
            ),
            Gap(8),
            Row(
              children: [
                Gap(8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Caption'),
                      Text('Joined On 4 April, MU 334'),
                      Text('#tag1 #tag2 #tag3'),
                    ],
                  ),
                ),
                Gap(8),
                IconButton(
                  icon: const Icon(Icons.bookmark_border),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert_rounded),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _CommunityView extends StatelessWidget {
  const _CommunityView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 20,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            AppNavigationService.newRoute(RoutesName.community);
          },
          child: Column(
            children: [
              Row(
                children: [
                  Gap(16),
                  CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey,
                      backgroundImage: ExtendedNetworkImageProvider(
                        MockData.randomImageAvatar(),
                      )),
                  Gap(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          'Location',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  Gap(8),
                  Icon(Icons.star),
                  Text(
                    'Rating 4.5',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                  Gap(8),
                  MaterialButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text('Join'),
                  ),
                  Gap(8),
                ],
              ),
              Gap(8),
              Stack(
                children: [
                  ExtendedImage.network(
                    MockData.randomImageAvatar(),
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
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
                        'Freelancer',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
              Gap(8),
              Row(
                children: [
                  Gap(8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Caption'),
                        Text('Joined On 4 April, MU 334'),
                        Text('#tag1 #tag2 #tag3'),
                      ],
                    ),
                  ),
                  Gap(8),
                  IconButton(
                    icon: const Icon(Icons.bookmark_border),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert_rounded),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PortfolioView extends StatelessWidget {
  const _PortfolioView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 20,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            AppNavigationService.newRoute(RoutesName.portfolio);
          },
          child: Column(
            children: [
              Row(
                children: [
                  Gap(16),
                  CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey,
                      backgroundImage: ExtendedNetworkImageProvider(
                        MockData.randomImageAvatar(),
                      )),
                  Gap(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          'Location',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  Gap(8),
                  Icon(Icons.star),
                  Text(
                    'Rating 4.5',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                  Gap(8),
                  MaterialButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text('Add Friend'),
                  ),
                  Gap(8),
                ],
              ),
              Gap(8),
              Stack(
                children: [
                  ExtendedImage.network(
                    MockData.randomImageAvatar(),
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
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
                        'Freelancer',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
              Gap(8),
              Row(
                children: [
                  Gap(8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Caption'),
                        Text('Joined On 4 April, MU 334'),
                        Text('#tag1 #tag2 #tag3'),
                      ],
                    ),
                  ),
                  Gap(8),
                  IconButton(
                    icon: const Icon(Icons.bookmark_border),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert_rounded),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AccountsView extends StatelessWidget {
  const _AccountsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 20,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Gap(16),
                  CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey,
                      backgroundImage: ExtendedNetworkImageProvider(
                        MockData.randomImageAvatar(),
                      )),
                  Gap(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          'Location',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  Gap(8),
                  MaterialButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text('Add Friend'),
                  ),
                  Gap(8),
                ],
              ),
              Gap(8),
              Row(
                children: [
                  Gap(8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Bio\n',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        'Looking for a Motion Graphic Artist in Delhi Studio XYZ. Looking for a Motion Graphic Artist in Delhi',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              TextSpan(
                                text: '\nLocation:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Delhi',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              TextSpan(
                                text: '\nStatus:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Online',
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
                  Gap(8),
                  IconButton(
                    icon: const Icon(Icons.bookmark_border),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert_rounded),
                    onPressed: () {},
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Mutual Friends: 10',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RecentView extends StatelessWidget {
  const _RecentView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 20,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        return Column(
          children: [
            Row(
              children: [
                Gap(16),
                CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey,
                    backgroundImage: ExtendedNetworkImageProvider(
                      MockData.randomImageAvatar(),
                    )),
                Gap(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Username',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        'Location',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
                Gap(8),
                Icon(Icons.star),
                Text(
                  'Rating 4.5',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                Gap(8),
                MaterialButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text('Add Friend'),
                ),
                Gap(8),
              ],
            ),
            Gap(8),
            Stack(
              children: [
                ExtendedImage.network(
                  MockData.randomImageAvatar(),
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
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
                      'Freelancer',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
              ],
            ),
            Gap(8),
            Row(
              children: [
                Gap(8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Caption'),
                      Text('Joined On 4 April, MU 334'),
                      Text('#tag1 #tag2 #tag3'),
                    ],
                  ),
                ),
                Gap(8),
                IconButton(
                  icon: const Icon(Icons.bookmark_border),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert_rounded),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
