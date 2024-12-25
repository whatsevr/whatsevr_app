import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/pepicons.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/widgets/whatsevr_icons.dart';

class WhatsevrMixPostTile extends StatelessWidget {
  static const String photo = 'photo';
  static const String video = 'video';
  static const String flick = 'flick';
 //on click
 // thumbnailUrl
  final String type;
  final VoidCallback? onClick;
  final String? thumbnailUrl;


  const WhatsevrMixPostTile({
    super.key,
    required this.type,
    this.onClick,
    this.thumbnailUrl,
   
  });

  Widget? _getOverlay() {
    switch (type) {
      case video:
        return const Icon(WhatsevrIcons.wtvIcon, color: Colors.white);
      case flick:
        return const Icon(WhatsevrIcons.flicksIcon001, color: Colors.white);
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(4.0),
              image: thumbnailUrl != null ? DecorationImage(
                image: ExtendedNetworkImageProvider(thumbnailUrl!),
                fit: BoxFit.cover,
              ) : DecorationImage(
                image: ExtendedNetworkImageProvider(MockData.randomImage()),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.center,
          ),
          if (_getOverlay() != null)
            Positioned(
              top: 8,
              right: 8,
              child: _getOverlay()!,
            ),
        ],
      ),
    );
  }
}