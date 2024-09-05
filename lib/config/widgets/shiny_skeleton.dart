import 'package:flutter/cupertino.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ShinySkeleton extends StatelessWidget {
  final Widget child;
  final Widget? skeleton;
  final bool showSkeleton;
  const ShinySkeleton(
      {super.key,
      required this.child,
      required this.showSkeleton,
      this.skeleton});

  @override
  Widget build(BuildContext context) {
    if (showSkeleton && skeleton != null) {
      return Skeletonizer(
        enabled: showSkeleton,
        ignorePointers: false,
        child: skeleton!,
      );
    }
    return Skeletonizer(
      enabled: showSkeleton,
      ignorePointers: false,
      child: child,
    );
  }
}
