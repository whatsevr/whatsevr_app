import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WhatsevrTabBarWithViews extends StatefulWidget {
  final bool? shrinkViews;
  final bool? isTabsScrollable;
  final List<String> tabs;
  final List<Widget> tabViews;
  final TabAlignment? tabAlignment;
  const WhatsevrTabBarWithViews({
    super.key,
    required this.tabs,
    this.shrinkViews,
    required this.tabViews,
    this.isTabsScrollable,
    this.tabAlignment,
  });

  @override
  State<WhatsevrTabBarWithViews> createState() => _WhatsevrTabBarWithViewsState();
}

class _WhatsevrTabBarWithViewsState extends State<WhatsevrTabBarWithViews> {
  void onTabChange(int index) {
    if (widget.shrinkViews == true) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.tabs.length,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          WhatsevrTabBar(
            onTabChange: onTabChange,
            tabs: widget.tabs,
            isScrollable: widget.isTabsScrollable,
            tabAlignment: widget.tabAlignment,
          ),
          const Gap(8),
          Builder(builder: (context) {
            if (widget.shrinkViews == true) {
              return IndexedStack(
                sizing: StackFit.loose,
                index: DefaultTabController.of(context).index,
                children: widget.tabViews,
              );
            }
            return Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: widget.tabViews,
              ),
            );
          }),
        ],
      ),
    );
  }
}

class WhatsevrTabBar extends StatelessWidget {
  final bool? isScrollable;
  final List<String> tabs;
  final TabAlignment? tabAlignment;
  final Function(int)? onTabChange;
  const WhatsevrTabBar({
    super.key,
    required this.tabs,
    this.isScrollable,
    this.tabAlignment,
    this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      onTap: onTabChange,
      tabAlignment: tabAlignment,
      isScrollable: isScrollable ?? false,
      indicatorColor: Colors.blue,
      labelColor: Colors.black,
      tabs: tabs.map((String e) => Tab(text: e)).toList(),
    );
  }
}
