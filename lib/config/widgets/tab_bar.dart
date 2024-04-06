import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WhatsevrTabBarWithViews extends StatelessWidget {
  final bool? isScrollable;
  final List<String> tabs;
  final List<Widget> tabViews;
  const WhatsevrTabBarWithViews({
    super.key,
    required this.tabs,
    required this.tabViews,
    this.isScrollable,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            tabAlignment: TabAlignment.fill,
            isScrollable: isScrollable ?? false,
            indicatorColor: Colors.blue,
            labelColor: Colors.black,
            tabs: tabs.map((e) => Tab(text: e)).toList(),
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
