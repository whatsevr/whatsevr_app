import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import '../../routes/router.dart';
import '../app_bar.dart';

void showPdfPreviewDialog(
    {BuildContext? context, String? pdfUrl, String? appBarTitle,}) {
  if (pdfUrl == null) return;
  context ??= AppNavigationService.currentContext!;
  showGeneralDialog(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) {
      return _Ui(url: pdfUrl, title: appBarTitle);
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
      body: PDF(
        fitEachPage: true,
        fitPolicy: FitPolicy.WIDTH,
        swipeHorizontal: false,
        autoSpacing: true,
        pageFling: true,
        pageSnap: true,
      ).cachedFromUrl(
        url,
        placeholder: (progress) => Center(child: Text('$progress %')),
        errorWidget: (error) => Center(child: Text(error.toString())),
      ),
    );
  }
}
