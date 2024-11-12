import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/akar_icons.dart';
import 'package:iconify_flutter/icons/fa6_solid.dart';
import 'package:iconify_flutter/icons/heroicons.dart';
import 'package:whatsevr_app/config/widgets/buttons/follow_unfollow.dart';
import 'package:whatsevr_app/config/widgets/max_scroll_listener.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';

import 'package:colorful_iconify_flutter/icons/vscode_icons.dart';
import 'package:whatsevr_app/src/features/community/views/page.dart';
import 'package:whatsevr_app/src/features/details/wtv_details/views/page.dart';
import 'package:whatsevr_app/src/features/search_pages/all_search/bloc/all_search_bloc.dart';
import 'package:whatsevr_app/utils/conversion.dart';

import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';
import 'package:whatsevr_app/config/widgets/tab_bar.dart';
import 'package:whatsevr_app/config/widgets/textfield/animated_search_field.dart';
import 'package:whatsevr_app/src/features/account/views/page.dart';

import '../../../../../config/api/response_model/search/searched_photo_posts.dart';
import '../../../../../config/widgets/dynamic_height_views.dart';
part 'widgets/recents.dart';
part 'widgets/users.dart';
part 'widgets/portfolios.dart';
part 'widgets/pdfs.dart';
part 'widgets/community.dart';
part 'widgets/photos.dart';
part 'widgets/flicks.dart';
part 'widgets/offers.dart';
part 'widgets/wtv.dart';

class AllSearchPage extends StatelessWidget {
  const AllSearchPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllSearchBloc(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Column(
              children: <Widget>[
                const SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: PadHorizontal.paddingValue),
                        child: WhatsevrAnimatedSearchField(
                          controller:
                              context.read<AllSearchBloc>().searchController,
                          hintTexts: <String>[
                            'Search User, Portfolio',
                            'Search Community',
                            'Search Wtv, Offers',
                            'Search Posts, Memories',
                          ],
                          showBackButton: true,
                          onChanged: (String value) {
                            context
                                .read<AllSearchBloc>()
                                .add(SearchTextChangedEvent(value));
                          },
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
          );
        },
      ),
    );
  }
}
