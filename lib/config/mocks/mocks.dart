import 'dart:math';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class MockData {
  static String randomImage([String? hw, int? index]) {
    final String url =
        'https://picsum.photos/${hw ?? '800/800'}?random=${index ?? Random().nextInt(100)}';

    return url;
  }

  static String get blankProfileAvatar {
    return 'https://dxvbdpxfzdpgiscphujy.supabase.co/storage/v1/object/public/assets/blank-profile.jpg';
  }

  static String get blankCommunityAvatar {
    return 'https://dxvbdpxfzdpgiscphujy.supabase.co/storage/v1/object/public/assets/team-icon-grey.png';
  }

  static String randomImageAvatar([String? hw, int? index]) {
    return 'https://i.pravatar.cc/${hw ?? 300}/?img=${index ?? Random().nextInt(50)}';
  }

  static List<String> get portraitVideos {
    return <String>{
      'https://firebasestorage.googleapis.com/v0/b/whatsevr-dev.appspot.com/o/demos%2F_muskan_023_-20240323-0001.mp4?alt=media&token=1236edd4-8779-4dcd-bc50-b0767d48c610',
      'https://firebasestorage.googleapis.com/v0/b/whatsevr-dev.appspot.com/o/demos%2Fitsnoah.d-20240323-0001.mp4?alt=media&token=ec00c766-61f4-40d3-b289-3a60c5be3b92',
      'https://firebasestorage.googleapis.com/v0/b/whatsevr-dev.appspot.com/o/demos%2Ftrisara_restaurant-20240323-0001.mp4?alt=media&token=55009adc-5c45-4f27-8612-9ecbc90d9db6',
      'https://firebasestorage.googleapis.com/v0/b/whatsevr-dev.appspot.com/o/demos%2Fharshitx.edits-20240323-0001.mp4?alt=media&token=e4f9b541-5eda-4ac5-9fe5-33855042da7a',
      'https://firebasestorage.googleapis.com/v0/b/whatsevr-dev.appspot.com/o/demos%2Fglamxxaleen-20240323-0001.mp4?alt=media&token=52cf4de8-88c0-4547-96bd-2d86dfbb1882',
    }.toList();
  }

  static String get demoVideo {
    return 'https://firebasestorage.googleapis.com/v0/b/whatsevr-dev.appspot.com/o/demos%2FAMPLIFIER%20x%20PUBG%20MOBILE%20MONTAGE%20(ULTRA%20HD)%20_%2069%20JOKER.mp4?alt=media&token=580b20c1-a339-4802-9c60-7379b0917ea3';
  }

  static String imagePlaceholder([
    String label = 'Image',
    bool isVertical = false,
  ]) {
    final Size size = isVertical ? Size(300, 600) : Size.square(300);
    return 'https://placehold.co/${size.width.toInt()}x${size.height.toInt()}/png?text=$label';
  }

  static ImageProvider imageProvider(String url) {
    return ExtendedImage(image: NetworkImage(url)).image;
  }
}
