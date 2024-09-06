import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:video_player/video_player.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
import 'package:whatsevr_app/config/widgets/shiny_skeleton.dart';
import 'package:whatsevr_app/src/features/account/views/widgets/about.dart';
import 'package:whatsevr_app/src/features/account/views/widgets/cover_media.dart';
import 'package:whatsevr_app/src/features/account/views/widgets/videos.dart';
import 'package:whatsevr_app/src/features/search_pages/account/views/page.dart';

import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/widgets/animated_search_field.dart';
import 'package:whatsevr_app/config/widgets/content_upload_button_sheet.dart';
import 'package:whatsevr_app/config/widgets/tab_bar.dart';

import '../../../../config/enums/post_creator_type.dart';
import '../../../../config/widgets/refresh_indicator.dart';
import '../../../../utils/conversion.dart';
import '../bloc/account_bloc.dart';

class AccountPageArgument {
  final bool isEditMode;
  final String? userUid;

  AccountPageArgument({required this.isEditMode, this.userUid});
}

class AccountPage extends StatelessWidget {
  final AccountPageArgument? pageArgument;
  AccountPage({super.key, required this.pageArgument});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountBloc()..add(AccountInitialEvent()),
      child: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          return Scaffold(
            body: Column(
              children: <Widget>[
                PadHorizontal(
                  child: WhatsevrAnimatedSearchField(
                    hintTexts: const <String>[
                      'Search for Account',
                      'Search for Portfolio',
                      'Search for Community',
                    ],
                    readOnly: true,
                    onTap: () {
                      AppNavigationService.newRoute(
                        RoutesName.accountSearch,
                        extras: const AccountSearchPage(
                          hintTexts: <String>[
                            'Search for Account',
                            'Search for Portfolio',
                            'Search for Community',
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const Gap(8),
                Expanded(
                  child: MyRefreshIndicator(
                    onPullDown: () async {
                      context.read<AccountBloc>().add(AccountInitialEvent());
                      await Future<void>.delayed(const Duration(seconds: 2));
                    },
                    child: ShinySkeleton(
                      showSkeleton: state.profileDetailsResponse == null,
                      child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          AccountPageCoverVideoView(),
                          const Gap(8),
                          PadHorizontal(
                            child: Text(
                              '${state.profileDetailsResponse?.userInfo?.portfolioTitle}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Gap(8),
                          PadHorizontal(
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: ExtendedImage.network(
                                    '${state.profileDetailsResponse?.userInfo?.profilePicture}',
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                    enableLoadState: false,
                                  ).image,
                                ),
                                Gap(8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                          '${state.profileDetailsResponse?.userInfo?.name}',
                                          style: TextStyle(fontSize: 14)),
                                      Text(
                                          ' @${state.profileDetailsResponse?.userInfo?.userName}',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey)),
                                      Gap(8),
                                    ],
                                  ),
                                ),
                                if (pageArgument?.isEditMode == true) ...[
                                  IconButton(
                                    icon: const Icon(Icons.add_box_rounded),
                                    onPressed: () {
                                      showContentUploadBottomSheet(context,
                                          postCreatorType: state
                                                      .profileDetailsResponse
                                                      ?.userInfo
                                                      ?.isPortfolio ==
                                                  true
                                              ? EnumPostCreatorType.PORTFOLIO
                                              : EnumPostCreatorType.ACCOUNT);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.menu),
                                    onPressed: () {
                                      AppNavigationService.newRoute(
                                          RoutesName.settings);
                                    },
                                  ),
                                ]
                              ],
                            ),
                          ),
                          const Gap(28),
                          PadHorizontal(
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text('1,000',
                                          style: TextStyle(fontSize: 20)),
                                      Text('Likes',
                                          style: TextStyle(fontSize: 14)),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text('1,000',
                                          style: TextStyle(fontSize: 20)),
                                      Text('Networks',
                                          style: TextStyle(fontSize: 14)),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text('1,000',
                                          style: TextStyle(fontSize: 20)),
                                      Text('Connections',
                                          style: TextStyle(fontSize: 14)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Gap(8),
                          if (false) ...[
                            const PadHorizontal(
                              child: Row(
                                children: <Widget>[
                                  Text('Suggestions',
                                      style: TextStyle(fontSize: 14)),
                                  Spacer(),
                                  Text('See All',
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                            ),
                            const Gap(8),
                            SizedBox(
                              height: 200,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                            left: index == 0 ? 8 : 0,
                                            right: 8,
                                          ),
                                          width: 150,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border:
                                                Border.all(color: Colors.black),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              const Gap(8),
                                              Expanded(
                                                child: ExtendedImage.network(
                                                  MockData.randomImageAvatar(),
                                                  shape: BoxShape.circle,
                                                  fit: BoxFit.cover,
                                                  enableLoadState: false,
                                                ),
                                              ),
                                              const Gap(8),
                                              const Text(
                                                'John Doe',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      MaterialButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        minWidth: 150,
                                        color: Colors.blue,
                                        onPressed: () {},
                                        child: const Text('Follow'),
                                      ),
                                    ],
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const Gap(8);
                                },
                                itemCount: 10,
                              ),
                            ),
                            const Gap(8),
                          ],
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: PadHorizontal.paddingValue,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12)),
                            ),
                            child: Column(
                              children: const <Widget>[
                                Gap(12),
                                WhatsevrTabBarWithViews(
                                  shrinkViews: true,
                                  tabAlignment: TabAlignment.start,
                                  isTabsScrollable: true,
                                  tabs: <String>[
                                    'About',
                                    'Services',
                                    'Media',
                                    'Videos',
                                    'Flicks',
                                    'Offerings',
                                    'Tags',
                                    'Pdf',
                                  ],
                                  tabViews: <Widget>[
                                    AccountPageAboutView(),
                                    Text('Services'),
                                    Text('Media'),
                                    AccountPageVideosView(),
                                    Text('Flicks'),
                                    Text('Tags'),
                                    Text('Offerings'),
                                    Text('Pdf'),
                                  ],
                                ),
                                Gap(8),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
