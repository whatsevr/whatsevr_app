import 'dart:async';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';

class MyRefreshIndicator extends StatelessWidget {
  final Widget child;
  final FutureOr<dynamic> Function()? onPullDown;
  final Axis? triggerAxis;

  MyRefreshIndicator({
    super.key,
    required this.child,
    this.onPullDown,
    this.triggerAxis,
  });

  final EasyRefreshController _controller = EasyRefreshController();
  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      header:triggerAxis== Axis.horizontal?const ClassicHeader():
       const MaterialHeader(),
      simultaneously: false,
      onRefresh: onPullDown,
      triggerAxis:triggerAxis?? Axis.vertical,
      child: child,
    );
  }
}
