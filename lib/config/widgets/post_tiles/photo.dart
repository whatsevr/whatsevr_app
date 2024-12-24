import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'package:whatsevr_app/config/mocks/mocks.dart';

class PhotoPostTile extends StatelessWidget {
  const PhotoPostTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(4.0),
        image: DecorationImage(
          image: ExtendedNetworkImageProvider(
            MockData.randomImage(),
          ),
          fit: BoxFit.cover,
        ),
      ),
      height: 150,
      alignment: Alignment.center,
    );
  }
}
