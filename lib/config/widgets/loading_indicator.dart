import 'package:flutter/cupertino.dart';

class WhatsevrLoadingIndicator extends StatelessWidget {
  const WhatsevrLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: CupertinoColors.white,
          ),
          child: CupertinoActivityIndicator()),
    );
  }
}
