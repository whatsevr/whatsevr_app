import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/heroicons.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/widgets/tab_bar.dart';

import 'package:whatsevr_app/config/routes/routes_name.dart';
import 'package:whatsevr_app/config/widgets/animated_search_field.dart';
import 'package:iconify_flutter/icons/akar_icons.dart';
import 'package:iconify_flutter/icons/fa6_solid.dart';

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
        children: <Widget>[
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: WhatsevrAnimatedSearchField(
                    hintTexts: hintTexts ?? <String>[],
                    showBackButton: true,
                  ),
                ),
              ),
              IconButton(
                icon: const Iconify(AkarIcons.settings_horizontal),
                onPressed: () {
                  showModalBottomSheet(
                      useRootNavigator: true,
                      isScrollControlled: true,
                      barrierColor: Colors.white.withOpacity(0.5),
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (BuildContext context) {
                        return IntrinsicHeight(
                          child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 4,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: <Widget>[
                                  const Gap(20),
                                  MaterialButton(
                                    elevation: 0,
                                    color: Colors.blueGrey.withOpacity(0.2),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 18,),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    onPressed: () {},
                                    child: const Row(
                                      children: <Widget>[
                                        Iconify(Heroicons
                                            .document_magnifying_glass_solid,),
                                        Gap(8),
                                        Text('Serve'),
                                      ],
                                    ),
                                  ),
                                  const Gap(8),
                                  MaterialButton(
                                    elevation: 0,
                                    color: Colors.blueGrey.withOpacity(0.2),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 18,),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    onPressed: () {},
                                    child: const Row(
                                      children: <Widget>[
                                        Iconify(
                                            Fa6Solid.magnifying_glass_chart,),
                                        Gap(8),
                                        Text('Status'),
                                      ],
                                    ),
                                  ),
                                  const Gap(8),
                                  MaterialButton(
                                    elevation: 0,
                                    color: Colors.blueGrey.withOpacity(0.2),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 18,),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    onPressed: () {},
                                    child: const Row(
                                      children: <Widget>[
                                        Iconify(
                                            Fa6Solid.magnifying_glass_chart,),
                                        Gap(8),
                                        Text('Location'),
                                      ],
                                    ),
                                  ),
                                  const Gap(35),
                                ],
                              ),),
                        );
                      },);
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Expanded(
            child: WhatsevrTabBarWithViews(
              tabAlignment: TabAlignment.start,
              isTabsScrollable: true,
              tabs: <String>[
                'Recents',
                'Accounts',
                'Portfolio',
                'Community',
                'Offers',
              ],
              tabViews: <Widget>[
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
  const _OffersView();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 20,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                const Gap(16),
                CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey,
                    backgroundImage: ExtendedNetworkImageProvider(
                      MockData.randomImageAvatar(),
                    ),),
                const Gap(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Username',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        'Location',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(8),
            Stack(
              children: <Widget>[
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
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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
                const Gap(8),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Caption'),
                      Text('Joined On 4 April, MU 334'),
                      Text('#tag1 #tag2 #tag3'),
                    ],
                  ),
                ),
                const Gap(8),
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
  const _CommunityView();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 20,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            AppNavigationService.newRoute(RoutesName.community);
          },
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Gap(16),
                  CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey,
                      backgroundImage: ExtendedNetworkImageProvider(
                        MockData.randomImageAvatar(),
                      ),),
                  const Gap(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Username',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          'Location',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                  const Gap(8),
                  const Icon(Icons.star),
                  const Text(
                    'Rating 4.5',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
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
                    child: const Text('Join'),
                  ),
                  const Gap(8),
                ],
              ),
              const Gap(8),
              Stack(
                children: <Widget>[
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
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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
                  const Gap(8),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Caption'),
                        Text('Joined On 4 April, MU 334'),
                        Text('#tag1 #tag2 #tag3'),
                      ],
                    ),
                  ),
                  const Gap(8),
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
  const _PortfolioView();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 20,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            AppNavigationService.newRoute(RoutesName.portfolio);
          },
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Gap(16),
                  CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey,
                      backgroundImage: ExtendedNetworkImageProvider(
                        MockData.randomImageAvatar(),
                      ),),
                  const Gap(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Username',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          'Location',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                  const Gap(8),
                  const Icon(Icons.star),
                  const Text(
                    'Rating 4.5',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
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
              const Gap(8),
              Stack(
                children: <Widget>[
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
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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
                  const Gap(8),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Caption'),
                        Text('Joined On 4 April, MU 334'),
                        Text('#tag1 #tag2 #tag3'),
                      ],
                    ),
                  ),
                  const Gap(8),
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
  const _AccountsView();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 20,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Gap(16),
                  CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey,
                      backgroundImage: ExtendedNetworkImageProvider(
                        MockData.randomImageAvatar(),
                      ),),
                  const Gap(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Username',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          'Location',
                          style: Theme.of(context).textTheme.titleMedium,
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
              const Gap(8),
              Row(
                children: <Widget>[
                  const Gap(8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          text: const TextSpan(
                            children: <InlineSpan>[
                              TextSpan(
                                text: 'Bio\n',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                children: <InlineSpan>[
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
                                children: <InlineSpan>[
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
                                children: <InlineSpan>[
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
                  const Gap(8),
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
              const Align(
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
  const _RecentView();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 20,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                const Gap(16),
                CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey,
                    backgroundImage: ExtendedNetworkImageProvider(
                      MockData.randomImageAvatar(),
                    ),),
                const Gap(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Username',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        'Location',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                const Gap(8),
                const Icon(Icons.star),
                const Text(
                  'Rating 4.5',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
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
            const Gap(8),
            Stack(
              children: <Widget>[
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
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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
                const Gap(8),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Caption'),
                      Text('Joined On 4 April, MU 334'),
                      Text('#tag1 #tag2 #tag3'),
                    ],
                  ),
                ),
                const Gap(8),
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
