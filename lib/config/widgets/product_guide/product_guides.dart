import 'package:flutter/material.dart';
import 'package:whatsevr_app/config/widgets/showAppModalSheet.dart';

import 'app_guide_view.dart';

class ProductGuides {
  static showWtvPostCreationGuide() {
    List<Widget> guides = [
      const Text('Select landscape/ horizontal video to create a wtv post.'),
      const Text('Vertical video are not allowed.'),
      const Text('Minimum video duration is 30 sec now.'),
      const Text('Maximum video duration is 1 hour now.'),
    ];
    showAppModalSheet(
        child: AppGuideView(
      headingTitle: 'WTV Post Creation Guide',
      guides: guides,
    ));
  }

  static showFlickPostCreationGuide() {
    List<Widget> guides = [
      const Text('Select portrait/ video video to create a flick post.'),
      const Text('Horizontal video are not allowed.'),
      const Text('Minimum video duration is 10 sec now.'),
      const Text('Maximum video duration is 6 min now.'),
    ];
    showAppModalSheet(
        child: AppGuideView(
      headingTitle: 'WTV Post Creation Guide',
      guides: guides,
    ));
  }
}
