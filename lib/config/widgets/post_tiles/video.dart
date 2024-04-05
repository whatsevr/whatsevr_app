import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../mocks/mocks.dart';

class VideoPostTile extends StatelessWidget {
  const VideoPostTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(18.0),
            image: DecorationImage(
              image: ExtendedNetworkImageProvider(
                MockData.randomImage(),
              ),
              fit: BoxFit.cover,
            ),
          ),
          height: 150,
          alignment: Alignment.center,
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Icon(
            Icons.play_arrow,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
