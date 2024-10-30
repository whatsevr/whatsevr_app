import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import '../../routes/router.dart';

import '../app_bar.dart';

void showPhotoPreviewDialog(
    {BuildContext? context, String? photoUrl, String? appBarTitle,}) {
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
