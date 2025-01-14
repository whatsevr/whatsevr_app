import 'package:flutter/material.dart';

class WhatsevrButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final bool miniButton;
  final bool hasIcon;
  final IconData? icon;
  final bool isOutlined;
  final bool shrink;
  final bool isTextButton;

  const WhatsevrButton._({
    required this.label,
    required this.onPressed,
    this.onLongPress,
    this.miniButton = false,
    this.hasIcon = false,
    this.icon,
    this.isOutlined = false,
    this.shrink = false,
    this.isTextButton = false,
  });

  // Factory for filled button with fixed color
  factory WhatsevrButton.filled({
    required String label,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    bool miniButton = false,
    bool shrink = false,
    bool hasIcon = false,
    IconData? icon,
  }) {
    return WhatsevrButton._(
      label: label,
      onPressed: onPressed,
      onLongPress: onLongPress,
      miniButton: miniButton,
      isOutlined: false,
      shrink: shrink,
      hasIcon: hasIcon,
      icon: icon,
    );
  }

  // Factory for outlined button with fixed color
  factory WhatsevrButton.outlined({
    required String label,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    bool miniButton = false,
    bool shrink = false,
    bool hasIcon = false,
    IconData? icon,
  }) {
    return WhatsevrButton._(
      label: label,
      onPressed: onPressed,
      onLongPress: onLongPress,
      miniButton: miniButton,
      isOutlined: true,
      shrink: shrink,
      hasIcon: hasIcon,
      icon: icon,
    );
  }

  // Factory for text button
  factory WhatsevrButton.text({
    required String label,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    bool miniButton = true,
    bool shrink = true,
    bool hasIcon = false,
    IconData? icon,
  }) {
    return WhatsevrButton._(
      label: label,
      onPressed: onPressed,
      onLongPress: onLongPress,
      miniButton: miniButton,
      isOutlined: false,
      shrink: shrink,
      isTextButton: true,
      hasIcon: hasIcon,
      icon: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color buttonColor = isOutlined ? Colors.white : Colors.black;
    final Color textColor = isOutlined ? Colors.black : Colors.white;
    final Color? borderColor = isOutlined ? Colors.black : null;

    return MaterialButton(
      elevation: 0,
      minWidth: shrink ? null : double.infinity,
      visualDensity: miniButton ? VisualDensity.compact : null,
      onPressed: () {
        onPressed?.call();
      },
      onLongPress: onLongPress,
      color: isTextButton ? Colors.transparent : buttonColor,
      padding: EdgeInsets.symmetric(
        vertical: miniButton ? 8 : 10.0,
        horizontal: miniButton ? 14 : 22.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(miniButton ? 4 : 8.0),
        side: borderColor == null || isTextButton
            ? BorderSide.none
            : BorderSide(color: borderColor),
      ),
      child: hasIcon
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(icon, size: 20, color: textColor),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                    color: textColor,
                  ),
                ),
              ],
            )
          : Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
                color: isTextButton ? Colors.black : textColor,
              ),
            ),
    );
  }
}
