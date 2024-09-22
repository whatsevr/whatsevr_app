import 'dart:async';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';

class MyRefreshIndicator extends StatelessWidget {
  final Widget child;
  final FutureOr<dynamic> Function()? onPullDown;
  final FutureOr<dynamic> Function()? onScrollFinished;
  const MyRefreshIndicator({
    super.key,
    required this.child,
    this.onPullDown,
    this.onScrollFinished,
  });

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      header: const MaterialHeader(),
      footer: const ClassicFooter(
        showMessage: false,
        showText: false,
      ),
      simultaneously: false,
      onRefresh: onPullDown,
      onLoad: onScrollFinished,
      triggerAxis: Axis.vertical,
      child: child,
    );
  }
}
