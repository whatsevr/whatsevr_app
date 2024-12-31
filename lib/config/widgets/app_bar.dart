import 'package:flutter/material.dart';
import 'package:whatsevr_app/config/themes/theme.dart';
import 'package:whatsevr_app/config/widgets/buttons/ai_button.dart';
import 'package:whatsevr_app/config/widgets/whatsevr_icons.dart';

class WhatsevrAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? showInfo;
  final List<Widget>? actions;
  final Widget? leading;
  final Color? backgroundColor;
  final bool showAiAction;
  const WhatsevrAppBar({
    super.key,
    required this.title,
    this.showInfo,
    this.actions,
    this.leading,
    this.backgroundColor,
    this.showAiAction = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white, // iOS-style white background
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE0E0E0), // Light gray border
            width: 1.0,
          ),
        ),
      ),
      child: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black, // Black title text
            fontSize: 17.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: <Widget>[
          ...?actions,
          if (showAiAction) const AiButton(),
          if (showInfo != null)
            IconButton(
              icon: Icon(WhatsevrIcons.iButtonIcon),
              onPressed: showInfo,
            ),
        ],
        leading: leading,

        backgroundColor: backgroundColor ?? context.whatsevrTheme.surface,
        elevation: 0.0, // iOS-style flat design
        centerTitle: true,
        surfaceTintColor: Colors.white, // Center the title like iOS
        iconTheme: const IconThemeData(
          color: Colors.black,
        ), // Black icon color for iOS style
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(45.0); // Custom height for the AppBar
}
