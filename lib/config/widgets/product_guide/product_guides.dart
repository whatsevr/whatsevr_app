import 'package:flutter/material.dart';
import 'package:whatsevr_app/config/widgets/showAppModalSheet.dart';

import 'app_guide_view.dart';

class ProductGuides {
  static showWtvPostCreationGuide() {
    List<Widget> guides = [
      const Text('Select landscape/ horizontal video to create a wtv post.'),
      const Text('Vertical video are not allowed.'),
      const Text('Maximum video duration is 1 hour now.'),
    ];
    showAppModalSheet(
        child: AppGuideView(
      headingTitle: 'WTV Post Creation Guide',
      guides: guides,
    ));
  }
}
