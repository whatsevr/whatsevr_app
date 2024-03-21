import 'package:flutter/material.dart';

class PadHorizontal extends StatelessWidget {
  final Widget child;
  const PadHorizontal({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: child,
    );
  }
}
