import 'package:animated_hint_textfield/animated_hint_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/akar_icons.dart';
import 'package:iconify_flutter/icons/heroicons.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/pepicons.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:whatsevr_app/src/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:whatsevr_app/src/features/flicks/views/page.dart';

import '../../../../config/widgets/pad_horizontal.dart';
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
          body: Column(
            children: [
              const Gap(8),
              PadHorizontal(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search),
                      const Gap(8),
                      Expanded(
                        child: AnimatedTextField(
                          animationType:
                              Animationtype.slide, // Use Animationtype.slide for Slide animations

                          decoration: InputDecoration.collapsed(
                            hintText: '',
                          ),
                          hintTexts: [
                            'Search for "Posts"',
                            'Search for "Profile"',
                            'Search for "Fliks"',
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(8),
              Expanded(child: state.currentDashboardView),
            ],
          ),
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
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Iconify(Ic.sharp_account_circle),
                    onPressed: () {},
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
