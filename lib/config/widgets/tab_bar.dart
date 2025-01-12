import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WhatsevrTabBarWithViews extends StatefulWidget {
  final bool? shrinkViews;
  final bool? isTabsScrollable;
  final List<(String tabName, Widget view)> tabViews;
  final TabAlignment? tabAlignment;
  final Function(int)? onTabChanged;
  final double? spaceBetween;
  final int initialIndex;
  final VoidCallback? onInit;
  const WhatsevrTabBarWithViews({
    super.key,
    this.shrinkViews,
    required this.tabViews,
    this.isTabsScrollable,
    this.tabAlignment,
    this.onTabChanged,
    this.spaceBetween,
    this.initialIndex = 0,
    this.onInit,
  });

  @override
  State<WhatsevrTabBarWithViews> createState() =>
      _WhatsevrTabBarWithViewsState();
}

class _WhatsevrTabBarWithViewsState extends State<WhatsevrTabBarWithViews> {
  void onTabChange(int index) {
    if (widget.shrinkViews == true) setState(() {});
    if (widget.onTabChanged != null) widget.onTabChanged!(index);
  }
  @override
  void initState() {
    super.initState();
    widget.onInit?.call();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.tabViews.length,
      initialIndex: widget.initialIndex,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          WhatsevrTabBar(
            onTabChange: onTabChange,
            tabs: widget.tabViews.map((e) => e.$1).toList(),
            isScrollable: widget.isTabsScrollable,
            tabAlignment: widget.tabAlignment,
          ),
          if (widget.spaceBetween != null) Gap(widget.spaceBetween!),
          Builder(
            builder: (BuildContext context) {
              if (widget.shrinkViews == true) {
                return widget
                    .tabViews[DefaultTabController.of(context).index].$2;
              }
              return Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: widget.tabViews.map((e) => e.$2).toList(),
                ),
              );
            },
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
      tabAlignment: tabAlignment ?? TabAlignment.start,
      isScrollable: isScrollable ?? true,
      indicatorColor: Colors.blue,
      labelColor: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      labelPadding: EdgeInsets.symmetric(horizontal: 16.w),
      labelStyle: TextStyle(fontSize: 14.sp),
      unselectedLabelStyle: TextStyle(fontSize: 14.sp),
      indicatorPadding: EdgeInsets.symmetric(horizontal: 4.w),
      indicatorWeight: 4.0.r,
      tabs: tabs.map((String e) => Tab(text: e)).toList(),
    );
  }
}
