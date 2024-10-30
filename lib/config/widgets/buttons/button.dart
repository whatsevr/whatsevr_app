import 'package:flutter/material.dart';

class WhatsevrButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool miniButton;
  final bool hasIcon;
  final IconData? icon;
  final bool isOutlined;
  final bool shrink;
  const WhatsevrButton._({
    required this.label,
    required this.onPressed,
    this.miniButton = false,
    this.hasIcon = false,
    this.icon,
    this.isOutlined = false,
    this.shrink = false,
  });

  // Factory for filled button with fixed color
  factory WhatsevrButton.filled({
    required String label,
    required VoidCallback onPressed,
    bool miniButton = false,
    bool shrink = false,
  }) {
    return WhatsevrButton._(
      label: label,
      onPressed: onPressed,
      miniButton: miniButton,
      isOutlined: false,
      shrink: shrink,
    );
  }

  // Factory for outlined button with fixed color
  factory WhatsevrButton.outlined({
    required String label,
    required VoidCallback onPressed,
    bool miniButton = false,
    bool shrink = false,
  }) {
    return WhatsevrButton._(
      label: label,
      onPressed: onPressed,
      miniButton: miniButton,
      isOutlined: true,
      shrink: shrink,
    );
  }

  // Factory for filled button with icon and fixed color
  factory WhatsevrButton.filledWithIcon({
    required String label,
    required VoidCallback onPressed,
    bool miniButton = false,
    required IconData icon,
    bool shrink = false,
  }) {
    return WhatsevrButton._(
      label: label,
      onPressed: onPressed,
      miniButton: miniButton,
      hasIcon: true,
      icon: icon,
      isOutlined: false,
      shrink: shrink,
    );
  }

  // Factory for outlined button with icon and fixed color
  factory WhatsevrButton.outlinedWithIcon({
    required String label,
    required VoidCallback onPressed,
    bool miniButton = false,
    required IconData icon,
    bool shrink = false,
  }) {
    return WhatsevrButton._(
      label: label,
      onPressed: onPressed,
      miniButton: miniButton,
      hasIcon: true,
      icon: icon,
      isOutlined: true,
      shrink: shrink,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Colors are fixed based on the button's style (filled/outlined) and color scheme (black/white)
    final Color buttonColor = isOutlined ? Colors.white : Colors.black;
    final Color textColor = isOutlined ? Colors.black : Colors.white;
    final Color? borderColor = isOutlined ? Colors.black : null;

    return MaterialButton(
      elevation: 0,
      minWidth: shrink ? null : double.infinity,
      visualDensity: miniButton ? VisualDensity.compact : null,
      onPressed: onPressed,
      color: buttonColor,
      padding: EdgeInsets.symmetric(
          vertical: miniButton ? 8 : 10.0, horizontal: miniButton ? 14 : 22.0,),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(miniButton ? 4 : 8.0),
        side: borderColor == null
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
                color: textColor,
              ),
            ),
    );
  }
}
