import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatsevr_app/config/widgets/ai_button.dart';
import 'package:whatsevr_app/generated/assets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final Color? backgroundColor;
  final bool showAiAction;
  const CustomAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.leading,
    this.backgroundColor,
    this.showAiAction = false,
  }) : super(key: key);

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
        title: Text(title,
            style: const TextStyle(
              color: Colors.black, // Black title text
              fontSize: 17.0,
              fontWeight: FontWeight.w600,
            )),
        actions: [
          ...?actions,
          if (showAiAction) AiButton(),
        ],
        leading: leading,

        backgroundColor: backgroundColor ?? Colors.white,
        elevation: 0.0, // iOS-style flat design
        centerTitle: true,
        surfaceTintColor: Colors.white, // Center the title like iOS
        iconTheme: const IconThemeData(
            color: Colors.black), // Black icon color for iOS style
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(45.0); // Custom height for the AppBar
}
