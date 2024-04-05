import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/pepicons.dart';

import '../../mocks/mocks.dart';

class FlickPostTile extends StatelessWidget {
  const FlickPostTile({super.key});

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
          height: 300,
          alignment: Alignment.center,
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Iconify(
            Pepicons.play_print,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
