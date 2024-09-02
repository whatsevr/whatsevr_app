import 'package:flutter/material.dart';

import 'package:whatsevr_app/config/mocks/mocks.dart';

import 'package:whatsevr_app/src/features/flicks/views/widgets/flick_view.dart';


class FlicksPage extends StatelessWidget {
  const FlicksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: MockData.portraitVideos.length,
        itemBuilder: (context, index) {
          return FlickPageFlickView(
            index: index,
          );
        },
      ),
    );
  }
}
