import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:detectable_text_field/widgets/detectable_text.dart';
import 'package:flutter/material.dart';

import 'package:whatsevr_app/config/services/launch_url.dart';

class WhatsevrPostDetectableText extends StatelessWidget {
  final String? text;
  const WhatsevrPostDetectableText({super.key, required this.text});

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

class WhatsevrMessageDetectableText extends StatelessWidget {
  final String? text;
  // More style properties
  final Color? moreStyleColor;
  final double? moreStyleFontSize;

  // Less style properties
  final Color? lessStyleColor;
  final double? lessStyleFontSize;

  // Detected style properties
  final Color? detectedStyleColor;
  final double? detectedStyleFontSize;

  // Basic style properties
  final double? basicStyleFontSize;
  final Color? basicStyleColor;

  // Other properties
  final Color? colorClickableText;
  final int? trimLines;
  final TrimMode? trimMode;

  const WhatsevrMessageDetectableText({
    super.key,
    this.text,
    this.moreStyleColor,
    this.moreStyleFontSize,
    this.lessStyleColor,
    this.lessStyleFontSize,
    this.detectedStyleColor,
    this.detectedStyleFontSize,
    this.basicStyleFontSize,
    this.basicStyleColor,
    this.colorClickableText,
    this.trimLines,
    this.trimMode,
  });

  @override
  Widget build(BuildContext context) {
    return DetectableText(
      text: text ?? '',
      trimLines: trimLines ?? 3,
      trimMode: trimMode ?? TrimMode.Line,
      moreStyle: TextStyle(
        color: moreStyleColor ?? Colors.grey,
        fontSize: moreStyleFontSize ?? 14,
      ),
      lessStyle: TextStyle(
        color: lessStyleColor ?? Colors.grey,
        fontSize: lessStyleFontSize ?? 14,
      ),
      detectionRegExp: detectionRegExp(
        hashtag: false,
        atSign: false,
      )!,
      detectedStyle: TextStyle(
        color: detectedStyleColor ?? Colors.blue,
        fontSize: detectedStyleFontSize ?? 13,
      ),
      basicStyle: TextStyle(
        fontSize: basicStyleFontSize ?? 13,
        color: basicStyleColor ?? Colors.black,
      ),
      onTap: (tappedText) {
        launchWebURL(context, url: tappedText);
      },
    );
  }
}
