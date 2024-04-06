import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/akar_icons.dart';
import 'package:iconify_flutter/icons/fa6_solid.dart';
import 'package:iconify_flutter/icons/heroicons.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/pepicons.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:whatsevr_app/src/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:whatsevr_app/src/features/flicks/views/page.dart';

import '../../../../config/mocks/mocks.dart';
import '../../account/views/page.dart';
import '../../chats/views/page.dart';
import '../../explore/views/page.dart';
import '../../home/views/page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc(),
      child: Builder(builder: (context) {
        return buildPage(context);
      }),
    );
  }

  Widget buildPage(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return Scaffold(
          body: state.currentDashboardView,
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Builder(
              builder: (context) {
                List<Widget> children = [
                  IconButton(
                    icon: Iconify(MaterialSymbols.explore),
                    onPressed: () {
                      context.read<DashboardBloc>().add(const TabChanged(
                            newView: ExplorePage(),
                          ));
                    },
                  ),
                  IconButton(
                    icon: Iconify(Heroicons.home_solid),
                    onPressed: () {
                      context.read<DashboardBloc>().add(const TabChanged(
                            newView: HomePage(),
                          ));
                    },
                  ),
                  IconButton(
                    icon: const Iconify(Ri.heart_add_fill),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Iconify(Pepicons.play_print),
                    onPressed: () {
                      context.read<DashboardBloc>().add(const TabChanged(
                            newView: FlicksPage(),
                          ));
                    },
                  ),
                  IconButton(
                    icon: Iconify(Ph.chat_circle_text_fill),
                    onPressed: () {
                      context.read<DashboardBloc>().add(const TabChanged(
                            newView: ChatsPage(),
                          ));
                    },
                  ),
                  IconButton(
                    icon: Iconify(Ic.twotone_notifications_none),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Iconify(AkarIcons.settings_horizontal),
                    onPressed: () {
                      showModalBottomSheet(
                          useRootNavigator: true,
                          isScrollControlled: true,
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height * 0.6,
                          ),
                          barrierColor: Colors.white.withOpacity(0.5),
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (context) {
                            return Container(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Gap(20),
                                    MaterialButton(
                                      elevation: 0,
                                      color: Colors.blueGrey.withOpacity(0.2),
                                      padding:
                                          const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      onPressed: () {},
                                      child: Row(
                                        children: [
                                          Iconify(Heroicons.document_magnifying_glass_solid),
                                          const Gap(8),
                                          const Text('Solutions'),
                                        ],
                                      ),
                                    ),
                                    Gap(8),
                                    MaterialButton(
                                      elevation: 0,
                                      color: Colors.blueGrey.withOpacity(0.2),
                                      padding:
                                          const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      onPressed: () {},
                                      child: Row(
                                        children: [
                                          Iconify(Fa6Solid.magnifying_glass_chart),
                                          const Gap(8),
                                          const Text('Status'),
                                        ],
                                      ),
                                    ),
                                    Gap(35),
                                    GridView.count(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                      childAspectRatio: 2 / 2.4,
                                      children: [
                                        for ((String title, String imgUrl) itm in [
                                          ('WTV', MockData.randomImageAvatar()),
                                          ('Posts', MockData.randomImageAvatar()),
                                          ('Portfolio', MockData.randomImageAvatar()),
                                          ('Jobs', MockData.randomImageAvatar()),
                                          ('Places', MockData.randomImageAvatar()),
                                          ('Community', MockData.randomImageAvatar()),
                                        ])
                                          Column(
                                            children: [
                                              Container(
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.blueGrey.withOpacity(0.2),
                                                  image: DecorationImage(
                                                    image: ExtendedNetworkImageProvider(
                                                      itm.$2,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Gap(8),
                                              Text('${itm.$1}'),
                                            ],
                                          )
                                      ],
                                    ),
                                  ],
                                ));
                          });
                    },
                  ),
                  IconButton(
                    icon: Iconify(Ic.sharp_account_circle),
                    onPressed: () {
                      context.read<DashboardBloc>().add(TabChanged(
                            newView: AccountPage(),
                          ));
                    },
                  ),
                ];
                return SizedBox(
                  height: 60,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return children[index];
                    },
                    separatorBuilder: (context, index) {
                      return Gap(10);
                    },
                    itemCount: children.length,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
