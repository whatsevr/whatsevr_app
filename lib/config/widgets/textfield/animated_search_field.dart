import 'package:animated_hint_textfield/animated_hint_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  late final ScrollController _defaultScrollController;

  @override
  void initState() {
    super.initState();
    widget.controller ??= TextEditingController();
    _defaultScrollController = ScrollController();
  }

  @override
  void dispose() {
    if (widget.hideOnScrollController == null) {
      _defaultScrollController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Hidable(
      controller: widget.hideOnScrollController ?? _defaultScrollController,
      preferredWidgetSize: Size(0, 40.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 6.0.h),
        decoration: BoxDecoration(
          color: context.whatsevrTheme.surface,
          border: Border.all(color: Colors.grey[400]!),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: <Widget>[
            if (widget.showBackButton ?? false)
              GestureDetector(
                onTap: () {
                  AppNavigationService.goBack();
                },
                child: Icon(Icons.arrow_back, size: 18.sp),
              ),
            if (widget.showBackButton != true) Icon(Icons.search, size: 18.sp),
            Gap(8.w),
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
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                ),
              ),
            ),
            Gap(8.w),
            if (widget.controller?.text.isNotEmpty ?? false)
              GestureDetector(
                onTap: () {
                  widget.controller?.clear();
                  setState(() {});
                },
                child: Icon(
                  Icons.close,
                  color: Colors.black,
                  size: 20.sp,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
