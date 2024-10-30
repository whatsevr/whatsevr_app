import 'package:flutter/material.dart';

class WhatsevrChoiceChip extends StatelessWidget {
  final bool choiced;
  final Function(bool)? switchChoice;
  final String label;

  const WhatsevrChoiceChip({super.key, 
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
      backgroundColor: Colors.white,
      selectedColor: Colors.black,
      labelStyle: TextStyle(
        color: choiced ? Colors.white : Colors.black,
      ),
      checkmarkColor: choiced ? Colors.white : Colors.black,
      onSelected: (value) {
        switchChoice?.call(value);
      },
    );
  }
}
