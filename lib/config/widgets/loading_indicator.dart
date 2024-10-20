import 'package:flutter/cupertino.dart';

class WhatsevrLoadingIndicator extends StatelessWidget {
  final bool showBorder;
  const WhatsevrLoadingIndicator({super.key, this.showBorder = true});

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: showBorder ? CupertinoColors.white : null,
          ),
          child: CupertinoActivityIndicator()),
    );
  }
}
