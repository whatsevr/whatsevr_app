import 'package:animated_hint_textfield/animated_hint_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WhatsevrAnimatedSearchField extends StatelessWidget {
  final List<String> hintTexts;
  const WhatsevrAnimatedSearchField({super.key, this.hintTexts = const []});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(Icons.search),
          const Gap(8),
          Expanded(
            child: AnimatedTextField(
              animationType: Animationtype.slide, // Use Animationtype.slide for Slide animations

              decoration: InputDecoration.collapsed(
                hintText: hintTexts.isNotEmpty ? hintTexts.first : 'Search',
              ),
              hintTexts: hintTexts,
            ),
          ),
        ],
      ),
    );
  }
}
