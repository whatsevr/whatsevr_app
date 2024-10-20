import 'package:detectable_text_field/detector/text_pattern_detector.dart';
import 'package:detectable_text_field/widgets/detectable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/services/launch_url.dart';
import 'package:whatsevr_app/config/widgets/button.dart';
import 'package:whatsevr_app/config/widgets/content_mask.dart';
import 'package:whatsevr_app/config/widgets/feed_players/wtv_full_player.dart';
import 'package:whatsevr_app/src/features/post_details_views/wtv_details/bloc/wtv_details_bloc.dart';
import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:whatsevr_app/src/features/post_details_views/wtv_details/views/widgets/related_videos.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
import 'package:whatsevr_app/utils/conversion.dart';

class WhatsevrDetectableText extends StatelessWidget {
  final String? text;
  const WhatsevrDetectableText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return DetectableText(
      text:
      text??'',
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
