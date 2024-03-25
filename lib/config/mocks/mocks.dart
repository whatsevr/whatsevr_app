import 'dart:math';

class MockData {
  static String get imageHxW {
    return 'https://placehold.jp/150x150.png';
  }

  static String get randomImage {
    return 'https://picsum.photos/200/300?random=${Random().nextInt(100)}';
  }

  static String get imagePlaceholderLandscape {
    return 'https://firebasestorage.googleapis.com/v0/b/whatsevr-dev.appspot.com/o/demos%2FPlaceholder_view_vector.svg.png?alt=media&token=7783263f-402f-4016-b522-2eebb48dd18b';
  }

  static String get imageAvatar {
    return 'https://firebasestorage.googleapis.com/v0/b/whatsevr-dev.appspot.com/o/demos%2Fimages.png?alt=media&token=dbac761f-fe05-4107-a48c-36439eb05bf9';
  }

  static List<String> get portraitVideos {
    return {
      'https://firebasestorage.googleapis.com/v0/b/whatsevr-dev.appspot.com/o/demos%2F_muskan_023_-20240323-0001.mp4?alt=media&token=1236edd4-8779-4dcd-bc50-b0767d48c610',
      'https://firebasestorage.googleapis.com/v0/b/whatsevr-dev.appspot.com/o/demos%2Fitsnoah.d-20240323-0001.mp4?alt=media&token=ec00c766-61f4-40d3-b289-3a60c5be3b92',
      'https://firebasestorage.googleapis.com/v0/b/whatsevr-dev.appspot.com/o/demos%2Ftrisara_restaurant-20240323-0001.mp4?alt=media&token=55009adc-5c45-4f27-8612-9ecbc90d9db6',
      'https://firebasestorage.googleapis.com/v0/b/whatsevr-dev.appspot.com/o/demos%2Fharshitx.edits-20240323-0001.mp4?alt=media&token=e4f9b541-5eda-4ac5-9fe5-33855042da7a',
      'https://firebasestorage.googleapis.com/v0/b/whatsevr-dev.appspot.com/o/demos%2Fglamxxaleen-20240323-0001.mp4?alt=media&token=52cf4de8-88c0-4547-96bd-2d86dfbb1882',
    }.toList();
  }
}
