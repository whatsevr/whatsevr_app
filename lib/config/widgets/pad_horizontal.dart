import 'package:flutter/material.dart';

class PadHorizontal extends StatelessWidget {
  static const double paddingValue = 12.0;
  static EdgeInsetsGeometry get padding =>
      const EdgeInsets.symmetric(horizontal: paddingValue);
  final Widget child;
  const PadHorizontal({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: paddingValue),
      child: child,
    );
  }
}
