import 'package:animated_hint_textfield/animated_hint_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../routes/router.dart';

class WhatsevrAnimatedSearchField extends StatefulWidget {
  final bool? readOnly;
  final bool? showBackButton;
  final void Function()? onTap;
  final List<String> hintTexts;
  late TextEditingController? controller;
  WhatsevrAnimatedSearchField({
    super.key,
    this.hintTexts = const [],
    this.readOnly,
    this.onTap,
    this.showBackButton,
    this.controller,
  });

  @override
  State<WhatsevrAnimatedSearchField> createState() => _WhatsevrAnimatedSearchFieldState();
}

class _WhatsevrAnimatedSearchFieldState extends State<WhatsevrAnimatedSearchField> {
  @override
  void initState() {
    super.initState();
    widget.controller ??= TextEditingController();
  }

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
          if (widget.showBackButton ?? false)
            GestureDetector(
                onTap: () {
                  AppNavigationService.goBack();
                },
                child: const Icon(Icons.arrow_back)),
          if (widget.showBackButton != true) const Icon(Icons.search),
          const Gap(8),
          Expanded(
            child: AnimatedTextField(
              animationType: Animationtype.slide, // Use Animationtype.slide for Slide animations
              readOnly: widget.readOnly ?? false,
              onTap: widget.onTap,
              decoration: InputDecoration.collapsed(
                hintText: widget.hintTexts.isNotEmpty ? widget.hintTexts.first : 'Search',
              ),
              hintTexts: widget.hintTexts,
              controller: widget.controller,
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          const Gap(8),
          if (widget.controller?.text.isNotEmpty ?? false)
            GestureDetector(
              onTap: () {
                widget.controller?.clear();
                setState(() {});
              },
              child: const Icon(
                Icons.close,
                color: Colors.black,
                size: 20,
              ),
            ),
        ],
      ),
    );
  }
}
