import 'package:detectable_text_field/widgets/detectable_text.dart';
import 'package:flutter/material.dart';
import 'package:whatsevr_app/config/services/launch_url.dart';
import 'package:detectable_text_field/detector/sample_regular_expressions.dart';

class WhatsevrDetectableText extends StatelessWidget {
  final String? text;
  const WhatsevrDetectableText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return DetectableText(
      text: text ?? '',
      trimLines: 3,
      trimMode: TrimMode.Line,
      colorClickableText: Colors.blue,
      moreStyle: TextStyle(
        color: Colors.grey,
        fontSize: 14,
      ),
      lessStyle: TextStyle(
        color: Colors.grey,
        fontSize: 14,
      ),
      detectionRegExp: detectionRegExp(
        hashtag: false,
        atSign: false,
      )!,
      detectedStyle: TextStyle(
        fontSize: 13,
        color: Colors.blue,
      ),
      basicStyle: TextStyle(
        fontSize: 13,
      ),
      onTap: (tappedText) {
        launchWebURL(context, url: tappedText);
      },
    );
  }
}
