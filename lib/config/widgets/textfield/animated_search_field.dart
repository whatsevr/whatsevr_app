import 'package:animated_hint_textfield/animated_hint_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hidable/hidable.dart';
import 'package:whatsevr_app/config/themes/theme.dart';

import 'package:whatsevr_app/config/routes/router.dart';

class WhatsevrAnimatedSearchField extends StatefulWidget {
  final ScrollController? hideOnScrollController;
  final bool? readOnly;
  final bool? showBackButton;
  final void Function()? onTap;
  final List<String> hintTexts;
  TextEditingController? controller;
  final void Function(String value)? onChanged;
  WhatsevrAnimatedSearchField({
    this.hideOnScrollController,
    super.key,
    this.hintTexts = const <String>[],
    this.readOnly,
    this.onTap,
    this.showBackButton,
    this.controller,
    this.onChanged,
  });

  @override
  State<WhatsevrAnimatedSearchField> createState() =>
      _WhatsevrAnimatedSearchFieldState();
}

class _WhatsevrAnimatedSearchFieldState
    extends State<WhatsevrAnimatedSearchField> {
  @override
  void initState() {
    super.initState();
    widget.controller ??= TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Hidable(
      controller: widget.hideOnScrollController ?? ScrollController(),
      preferredWidgetSize: const Size(0, 40),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: context.whatsevrTheme.surface,
          border: Border.all(color: Colors.grey[400]!),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: <Widget>[
            if (widget.showBackButton ?? false)
              GestureDetector(
                onTap: () {
                  AppNavigationService.goBack();
                },
                child: const Icon(Icons.arrow_back),
              ),
            if (widget.showBackButton != true) const Icon(Icons.search),
            const Gap(8),
            Expanded(
              child: AnimatedTextField(
                animationType: Animationtype
                    .slide, // Use Animationtype.slide for Slide animations
                readOnly: widget.readOnly ?? false,
                onTap: widget.onTap,
                decoration: InputDecoration.collapsed(
                  hintText: widget.hintTexts.isNotEmpty
                      ? widget.hintTexts.first
                      : 'Search',
                ),
                hintTexts: widget.hintTexts,
                controller: widget.controller,
                onChanged: (String value) {
                  setState(() {});
                  widget.onChanged?.call(value);
                },
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
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
      ),
    );
  }
}
