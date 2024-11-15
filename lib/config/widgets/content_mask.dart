import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:whatsevr_app/config/widgets/loading_indicator.dart';

class ContentMask extends StatelessWidget {
  final Widget child;
  final Widget? customMask;
  final bool showMask;
  const ContentMask({
    super.key,
    required this.child,
    required this.showMask,
    this.customMask,
  });

  @override
  Widget build(BuildContext context) {
    if (showMask) {
      return Skeletonizer(
        enabled: showMask,
        ignorePointers: true,
        child: customMask ??
            const Center(
              child: WhatsevrLoadingIndicator(),
            ),
      );
    }
    return Skeletonizer(
      enabled: showMask,
      ignorePointers: false,
      child: child,
    );
  }
}
