import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/akar_icons.dart';
import 'package:iconify_flutter/icons/fa6_solid.dart';
import 'package:iconify_flutter/icons/heroicons.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';

import 'package:colorful_iconify_flutter/icons/vscode_icons.dart';
import 'package:whatsevr_app/src/features/search_pages/all_search/bloc/all_search_bloc.dart';
import 'package:whatsevr_app/utils/conversion.dart';
// widget
import '../../../../../config/mocks/mocks.dart';
import '../../../../../config/routes/router.dart';
import '../../../../../config/routes/routes_name.dart';
import '../../../../../config/widgets/tab_bar.dart';
import '../../../../../config/widgets/textfield/animated_search_field.dart';
import '../../../account/views/page.dart';

class AllSearchPage extends StatelessWidget {
  const AllSearchPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllSearchBloc(),
      child: Scaffold(
        body: Column(
          children: <Widget>[
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: PadHorizontal.paddingValue),
                    child: WhatsevrAnimatedSearchField(
                      hintTexts: <String>[
                        'Search User, Portfolio',
                        'Search Community',
                        'Search Wtv, Offers',
                        'Search Posts, Memories',
                      ],
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
                                    horizontal: 25,
                                    vertical: 18,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  onPressed: () {},
                                  child: const Row(
                                    children: <Widget>[
                                      Iconify(
                                        Heroicons
                                            .document_magnifying_glass_solid,
                                      ),
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
                                    horizontal: 25,
                                    vertical: 18,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  onPressed: () {},
                                  child: const Row(
                                    children: <Widget>[
                                      Iconify(
                                        Fa6Solid.magnifying_glass_chart,
                                      ),
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
                                    horizontal: 25,
                                    vertical: 18,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  onPressed: () {},
                                  child: const Row(
                                    children: <Widget>[
                                      Iconify(
                                        Fa6Solid.magnifying_glass_chart,
                                      ),
                                      Gap(8),
                                      Text('Location'),
                                    ],
                                  ),
                                ),
                                const Gap(35),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: WhatsevrTabBarWithViews(
                onTabChanged: (index) {
                  context.read<AllSearchBloc>().add(TabChangedEvent(index));
                },
                tabAlignment: TabAlignment.start,
                isTabsScrollable: true,
                tabViews: [
                  ('Recent', _RecentView()),
                  ('Accounts', _AccountsView()),
                  ('Portfolio', _PortfolioView()),
                  ('Community', _CommunityView()),
                  ('Offers', _OffersView()),
                  ('Wtv', _WtvView()),
                  ('Flicks', _FlicksView()),
                  ('Photos', _PhotosView()),
                  ('Pdfs', _PdfsView()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OffersView extends StatelessWidget {
  const _OffersView();

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> offers = List.generate(20, (int index) {
      return {
        'status': 'Active',
        'title': 'Offer Title $index',
        'description': 'Offer Description $index',
        'filesData': [
          {'type': 'image', 'imageUrl': MockData.randomImage()},
          {'type': 'video', 'videoThumbnailUrl': MockData.randomImage()}
        ],
        'totalImpressions': 1000,
        'totalLikes': 100,
        'totalComments': 10,
        'totalShares': 20,
      };
    });

    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (BuildContext context, int index) {
        return const Gap(4);
      },
      itemCount: offers.length,
      itemBuilder: (BuildContext context, int index) {
        final Map<String, dynamic> offer = offers[index];
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey[300]!,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      offer['status'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Gap(4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          offer['title'],
                          maxLines: 2,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const Gap(4),
                      const Icon(Icons.more_horiz),
                    ],
                  ),
                  if (offer['filesData'].isEmpty) ...[
                    const Gap(4),
                    Text(
                      offer['description'],
                      maxLines: 8,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ],
              ),
              if (offer['filesData'].isNotEmpty) ...[
                const Gap(8),
                SizedBox(
                  height: 120,
                  child: ListView.separated(
                    itemCount: offer['filesData'].length,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (BuildContext context, int index) {
                      return const Gap(8);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      final Map<String, dynamic> fileData =
                          offer['filesData'][index];
                      if (fileData['type'] == 'image' ||
                          fileData['type'] == 'video') {
                        return ExtendedImage.network(
                          fileData['imageUrl'] ??
                              fileData['videoThumbnailUrl'] ??
                              '',
                          fit: BoxFit.cover,
                          enableLoadState: false,
                          cache: true,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(8),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
              ],
              const Gap(12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (final record in [
                    (
                      offer['totalImpressions'].toString(),
                      Icons.remove_red_eye
                    ),
                    (offer['totalLikes'].toString(), Icons.thumb_up_sharp),
                    (offer['totalComments'].toString(), Icons.comment),
                    (offer['totalShares'].toString(), Icons.share_sharp),
                  ])
                    Row(
                      children: [
                        Text(
                          record.$1,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        const Gap(4),
                        Icon(
                          record.$2,
                          size: 16,
                        ),
                        const Gap(8),
                      ],
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
                    ),
                  ),
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
            AppNavigationService.newRoute(
              RoutesName.account,
              extras: AccountPageArgument(isEditMode: false),
            );
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
                    ),
                  ),
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
                    ),
                  ),
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
                  ),
                ),
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

class _WtvView extends StatelessWidget {
  const _WtvView();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 20,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                ExtendedImage.network(
                  MockData.randomImageAvatar(),
                  borderRadius: BorderRadius.circular(8),
                  shape: BoxShape.rectangle,
                  fit: BoxFit.cover,
                  height: 120,
                  width: 170,
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Duration',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Text(
                          '${formatCountToKMBTQ(3532626)}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        Gap(4),
                        const Icon(
                          Icons.remove_red_eye,
                          color: Colors.white,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Gap(8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'Video Title $index',
                          maxLines: 3,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Gap(4),
                      Icon(Icons.more_horiz),
                    ],
                  ),
                  Text(
                    '100 likes • 10 comments',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '20 shares • 5 tagged',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '2 hours ago',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _FlicksView extends StatelessWidget {
  const _FlicksView();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 9 / 21,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: 20,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 9 / 16,
              child: Stack(
                children: <Widget>[
                  ExtendedImage.network(
                    MockData.randomImageAvatar(),
                    borderRadius: BorderRadius.circular(8),
                    shape: BoxShape.rectangle,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    enableLoadState: false,
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Duration',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Text(
                            '${formatCountToKMBTQ(3532626)}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          Gap(4),
                          const Icon(
                            Icons.remove_red_eye,
                            color: Colors.white,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'Title',
                          maxLines: 3,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Gap(4),
                      Icon(Icons.more_horiz),
                    ],
                  ),
                  Text(
                    'Likes • Comments',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'Shares • Tagged',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'Date',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PhotosView extends StatelessWidget {
  const _PhotosView();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 20,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {},
              child: ExtendedImage.network(
                MockData.randomImageAvatar(),
                width: double.infinity,
                fit: BoxFit.cover,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const Gap(8),
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage:
                      ExtendedNetworkImageProvider(MockData.blankProfileAvatar),
                ),
                const Gap(8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <StatelessWidget>[
                      Text(
                        'Title',
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(8),
                      Text(
                        'Updated on Date',
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(8),
            Text(
              'Description',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PdfsView extends StatelessWidget {
  const _PdfsView();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 20,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {},
              child: ExtendedImage.network(
                MockData.randomImageAvatar(),
                width: double.infinity,
                fit: BoxFit.cover,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const Gap(8),
            Row(
              children: <Widget>[
                const Iconify(
                  VscodeIcons.file_type_pdf2,
                  size: 45,
                ),
                const Gap(8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <StatelessWidget>[
                      Text(
                        'Title',
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(8),
                      Text(
                        'Updated on Date',
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(8),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.download,
                    size: 30,
                  ),
                ),
              ],
            ),
            const Gap(8),
            Text(
              'Description',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        );
      },
    );
  }
}
