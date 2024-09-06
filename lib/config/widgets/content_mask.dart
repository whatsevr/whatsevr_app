import 'package:flutter/cupertino.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ContentMask extends StatelessWidget {
  final Widget child;
  final Widget? customMask;
  final bool showMask;
  const ContentMask(
      {super.key,
      required this.child,
      required this.showMask,
      this.customMask});

  @override
  Widget build(BuildContext context) {
    if (showMask) {
      return Skeletonizer(
        enabled: showMask,
        ignorePointers: true,
        child: customMask ??
            Center(
              child: CupertinoActivityIndicator(),
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
