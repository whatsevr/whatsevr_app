import 'package:flutter/material.dart';
import 'package:whatsevr_app/config/widgets/showAppModalSheet.dart';

import 'app_guide_view.dart';

class ProductGuides {
  static showWtvPostCreationGuide() {
    List<Widget> guides = [
      const Text('Select landscape/ horizontal video to create a video post.'),
      const Text('Vertical video are not allowed.'),
      const Text('Minimum video duration is 30 sec now.'),
      const Text('Maximum video duration is 1 hour now.'),
    ];
    showAppModalSheet(
        child: AppGuideView(
      headingTitle: 'Video Post Creation Guide',
      guides: guides,
    ));
  }

  static showFlickPostCreationGuide() {
    List<Widget> guides = [
      const Text('Select portrait video video to create a flick.'),
      const Text('Horizontal video are not allowed.'),
      const Text('Minimum video duration is 5 sec now.'),
      const Text('Maximum video duration is 2 min now.'),
    ];
    showAppModalSheet(
        child: AppGuideView(
      headingTitle: 'Flick Creation Guide',
      guides: guides,
    ));
  }

  static showMemoryCreationGuide() {
    List<Widget> guides = [
      const Text('Select portrait or landscape video to create a memory.'),
      const Text('Minimum video duration is 5 sec now.'),
      const Text('Maximum video duration is 30 sec now.'),
    ];
    showAppModalSheet(
        child: AppGuideView(
      headingTitle: 'Memory Creation Guide',
      guides: guides,
    ));
  }

  static showOfferCreationGuide() {
    List<Widget> guides = [
      const Text(
          'Select landscape or square video or image to create a offer.'),
      const Text('Minimum video duration is 10 sec now.'),
      const Text('Maximum video duration is 5 min now.'),
    ];
    showAppModalSheet(
        child: AppGuideView(
      headingTitle: 'Offer Creation Guide',
      guides: guides,
    ));
  }

  static showPhotoPostCreationGuide() {
    List<Widget> guides = [
      const Text(
          'Select landscape or square or vertical images to create a offer.'),
      const Text('Maximum 10 images can be post in one post.'),
    ];
    showAppModalSheet(
        child: AppGuideView(
      headingTitle: 'Photo Post Creation Guide',
      guides: guides,
    ));
  }
}
