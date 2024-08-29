import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'package:whatsevr_app/config/mocks/mocks.dart';

class PortfolioVideoPostTile extends StatelessWidget {
  const PortfolioVideoPostTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
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
          width: double.infinity,
          alignment: Alignment.center,
        ),
        const Positioned(
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
