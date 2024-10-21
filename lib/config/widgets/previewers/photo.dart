import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/widgets/feed_players/flick_full_player.dart';
import 'package:whatsevr_app/config/widgets/media/aspect_ratio.dart';

import '../app_bar.dart';

showPhotoPreviewDialog(
    {BuildContext? context, String? photoUrl, String? appBarTitle}) {
  if (photoUrl == null) return;
  context ??= AppNavigationService.currentContext!;
  showGeneralDialog(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) {
      return _Ui(url: photoUrl, title: appBarTitle);
    },
  );
}

class _Ui extends StatelessWidget {
  final String url;
  final String? title;

  const _Ui({
    super.key,
    required this.url,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WhatsevrAppBar(title: title ?? 'Pdf'),
      body: Center(
        child: ExtendedImage.network(
          url,
          width: double.infinity,
          fit: BoxFit.contain,
          enableLoadState: false,
          mode: ExtendedImageMode.gesture,
        ),
      ),
    );
  }
}
