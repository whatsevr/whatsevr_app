import 'package:flutter/material.dart';

class WhatsevrButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isFilled;
  final bool hasIcon;
  final IconData? icon;
  final bool isOutlined;
  final bool shrink;
  const WhatsevrButton._({
    Key? key,
    required this.label,
    required this.onPressed,
    this.isFilled = true,
    this.hasIcon = false,
    this.icon,
    this.isOutlined = false,
    this.shrink = false,
  }) : super(key: key);

  // Factory for filled button with fixed color
  factory WhatsevrButton.filled({
    required String label,
    required VoidCallback onPressed,
    bool shrink = false,
  }) {
    return WhatsevrButton._(
      label: label,
      onPressed: onPressed,
      isFilled: true,
      isOutlined: false,
      shrink: shrink,
    );
  }

  // Factory for outlined button with fixed color
  factory WhatsevrButton.outlined({
    required String label,
    required VoidCallback onPressed,
    bool shrink = false,
  }) {
    return WhatsevrButton._(
      label: label,
      onPressed: onPressed,
      isFilled: false,
      isOutlined: true,
      shrink: shrink,
    );
  }

  // Factory for filled button with icon and fixed color
  factory WhatsevrButton.filledWithIcon({
    required String label,
    required VoidCallback onPressed,
    required IconData icon,
    bool shrink = false,
  }) {
    return WhatsevrButton._(
      label: label,
      onPressed: onPressed,
      isFilled: true,
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
    required IconData icon,
    bool shrink = false,
  }) {
    return WhatsevrButton._(
      label: label,
      onPressed: onPressed,
      isFilled: false,
      hasIcon: true,
      icon: icon,
      isOutlined: true,
      shrink: shrink,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Colors are fixed based on the button's style (filled/outlined) and color scheme (black/white)
    final Color buttonColor = isFilled ? Colors.black : Colors.white;
    final Color textColor = isFilled ? Colors.white : Colors.black;
    final Color borderColor = isFilled ? Colors.white : Colors.black;

    return MaterialButton(
      minWidth: shrink ? 0 : double.infinity,
      onPressed: onPressed,
      color: buttonColor,
      textColor: textColor,
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
        side: isOutlined ? BorderSide(color: borderColor) : BorderSide.none,
      ),
      child: hasIcon
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(icon, size: 20),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            )
          : Text(
              label,
              style: const TextStyle(fontSize: 16),
            ),
    );
  }
}
