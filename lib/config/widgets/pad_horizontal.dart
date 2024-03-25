import 'package:flutter/material.dart';

class PadHorizontal extends StatelessWidget {
  static const double padding = 12.0;
  final Widget child;
  const PadHorizontal({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: padding),
      child: child,
    );
  }
}
