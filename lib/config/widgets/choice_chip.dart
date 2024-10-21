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
      label: Text(label),
      selected: selected,
      onSelected: (value) {
        onSelected?.call(value);
      },
    );
  }
}
