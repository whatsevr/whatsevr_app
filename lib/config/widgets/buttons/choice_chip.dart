import 'package:flutter/material.dart';
import 'package:whatsevr_app/config/themes/theme.dart';

class WhatsevrChoiceChip extends StatelessWidget {
  final bool choiced;
  final Function(bool)? switchChoice;
  final String label;

  const WhatsevrChoiceChip({
    super.key,
    required this.label,
    this.choiced = false,
    this.switchChoice,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      label: Text(label),
      selected: choiced,
      backgroundColor: context.whatsevrTheme.surface,
      selectedColor: Colors.black,
      labelStyle: TextStyle(
        color: choiced ? Colors.white : Colors.black,
      ),
      checkmarkColor: choiced ? context.whatsevrTheme.surface : Colors.black,
      onSelected: (value) {
        switchChoice?.call(value);
      },
    );
  }
}
