import 'package:flutter/material.dart';

class WhatsevrChoiceChip extends StatelessWidget {
  final bool selected;
  final Function(bool)? onSelected;
  final String label;

  WhatsevrChoiceChip({
    required this.label,
    this.selected = false,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      label: Text(label),
      selected: selected,
      backgroundColor: Colors.white,
      selectedColor: Colors.black,
      labelStyle: TextStyle(
        color: selected ? Colors.white : Colors.black,
      ),
      checkmarkColor: selected ? Colors.white : Colors.black,
      onSelected: (value) {
        onSelected?.call(value);
      },
    );
  }
}
