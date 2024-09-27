import 'dart:async';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';

class MyRefreshIndicator extends StatelessWidget {
  final Widget child;
  final FutureOr<dynamic> Function()? onPullDown;

  MyRefreshIndicator({
    super.key,
    required this.child,
    this.onPullDown,
  });
  final EasyRefreshController _controller = EasyRefreshController();
  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      header: const MaterialHeader(),
      simultaneously: false,
      onRefresh: onPullDown,
      triggerAxis: Axis.vertical,
      child: child,
    );
  }
}
