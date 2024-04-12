import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WhatsevrTabBarWithViews extends StatelessWidget {
  final bool? isScrollable;
  final List<String> tabs;
  final List<Widget> tabViews;
  final TabAlignment? tabAlignment;
  const WhatsevrTabBarWithViews({
    super.key,
    required this.tabs,
    required this.tabViews,
    this.isScrollable,
    this.tabAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WhatsevrTabBar(
            tabs: tabs,
            isScrollable: isScrollable,
            tabAlignment: tabAlignment,
          ),
          const Gap(8),
          Expanded(
            child: TabBarView(
              children: tabViews,
            ),
          ),
        ],
      ),
    );
  }
}

class WhatsevrTabBar extends StatelessWidget {
  final bool? isScrollable;
  final List<String> tabs;
  final TabAlignment? tabAlignment;
  const WhatsevrTabBar({super.key, required this.tabs, this.isScrollable, this.tabAlignment});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabAlignment: tabAlignment,
      isScrollable: isScrollable ?? false,
      indicatorColor: Colors.blue,
      labelColor: Colors.black,
      tabs: tabs.map((e) => Tab(text: e)).toList(),
    );
  }
}
