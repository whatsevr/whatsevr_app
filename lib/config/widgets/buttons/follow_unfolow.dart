import 'package:flutter/material.dart';
import 'package:whatsevr_app/config/widgets/buttons/button.dart';
import 'package:whatsevr_app/config/widgets/buttons/two_state_ui.dart';
import 'package:whatsevr_app/config/widgets/stack_toast.dart';

import '../../themes/theme.dart';

class WhatsevrFollowButton extends StatelessWidget {
  final Color? firstStateColor;
  final Color? secondStateColor;
  final bool? isFollowed;
  final Function(bool? actionSuccess)? onFollow;
  final Function(bool? actionSuccess)? onUnFollowed;
  final bool filledButton;
  const WhatsevrFollowButton({
    super.key,
    this.isFollowed,
    this.onFollow,
    this.onUnFollowed,
    this.firstStateColor,
    this.secondStateColor,
    this.filledButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.whatsevrTheme;
    return WhatsevrTwoStateUi(
      isSecondState: isFollowed ?? false,
      onStateChanged: (isSecondState, isFirstState) {
        if (isSecondState) {
          onFollow?.call(null);
        } else if (isFirstState) {
          WhatsevrStackToast.showWarning('Unfollowed');
          onUnFollowed?.call(null);
        }
      },
      firstStateUi: filledButton
          ? WhatsevrButton.filled(
              miniButton: true,
              shrink: true,
              label: 'Follow',
            )
          : WhatsevrButton.outlined(
              miniButton: true,
              shrink: true,
              label: 'Follow',
            ),
      secondStateUi: filledButton
          ? WhatsevrButton.text(
              miniButton: true,
              shrink: true,
              label: 'Following',
            )
          : WhatsevrButton.text(
              miniButton: true,
              shrink: true,
              label: 'Following',
            ),
    );
  }
}
