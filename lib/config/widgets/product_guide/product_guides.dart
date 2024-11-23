import 'package:flutter/material.dart';
import 'package:whatsevr_app/config/widgets/dialogs/showAppModalSheet.dart';

import 'package:whatsevr_app/config/widgets/product_guide/app_guide_view.dart';

class ProductGuides {
  static showWtvPostCreationGuide() {
    final List<Widget> guides = [
      const Text('Select landscape/ horizontal video to create a video post.'),
      const Text('Vertical video are not allowed.'),
      const Text('Minimum video duration is 30 sec now.'),
      const Text('Maximum video duration is 1 hour now.'),
    ];
    showAppModalSheet(
      child: AppGuideView(
        headingTitle: 'Video Post Creation Guide',
        guides: guides,
      ),
    );
  }

  static showFlickPostCreationGuide() {
    final List<Widget> guides = [
      const Text('Select portrait video video to create a flick.'),
      const Text('Horizontal video are not allowed.'),
      const Text('Minimum video duration is 5 sec now.'),
      const Text('Maximum video duration is 2 min now.'),
    ];
    showAppModalSheet(
      child: AppGuideView(
        headingTitle: 'Flick Creation Guide',
        guides: guides,
      ),
    );
  }

  static showMemoryCreationGuide() {
    final List<Widget> guides = [
      const Text('Select portrait or landscape video to create a memory.'),
      const Text('Minimum video duration is 5 sec now.'),
      const Text('Maximum video duration is 30 sec now.'),
    ];
    showAppModalSheet(
      child: AppGuideView(
        headingTitle: 'Memory Creation Guide',
        guides: guides,
      ),
    );
  }

  static showOfferCreationGuide() {
    final List<Widget> guides = [
      const Text(
        'Select landscape or square video or image to create a offer.',
      ),
      const Text('Minimum video duration is 10 sec now.'),
      const Text('Maximum video duration is 5 min now.'),
    ];
    showAppModalSheet(
      child: AppGuideView(
        headingTitle: 'Offer Creation Guide',
        guides: guides,
      ),
    );
  }

  static showPhotoPostCreationGuide() {
    final List<Widget> guides = [
      const Text(
        'Select landscape or square or vertical images to create a offer.',
      ),
      const Text('Maximum 10 images can be post in one post.'),
    ];
    showAppModalSheet(
      child: AppGuideView(
        headingTitle: 'Photo Post Creation Guide',
        guides: guides,
      ),
    );
  }

  static showUploadPdfGuide() {
    final List<Widget> guides = [
      const Text('Thumbnail should be in landscape or square aspect ratio.'),
      const Text(
        'Max file size is 25 MB, only one PDF files are allowed to upload.',
      ),
      const Text('Uploading new PDF will replace the existing PDF.'),
    ];
    showAppModalSheet(
      child: AppGuideView(
        headingTitle: 'PDF Upload Guide',
        guides: guides,
      ),
    );
  }
}
