import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';
import 'package:whatsevr_app/config/widgets/whatsevr_icons.dart';
import 'package:whatsevr_app/src/features/details/wtv_details/views/page.dart';

class WhatsevrMixPostTile extends StatelessWidget {
  static const String photo = 'photo';
  static const String wtv = 'wtv';
  static const String flick = 'flick';
  static const String offer = 'offer';

  final String? tileType;

  final String? thumbnailUrl;

  final String? uid;

  const WhatsevrMixPostTile({
    super.key,
    required this.tileType,
    required this.uid,
    this.thumbnailUrl,
  });

  Widget? _getOverlay() {
    final double iconSize = 16.0;
    switch (tileType) {
      case wtv:
        return Icon(WhatsevrIcons.wtvIcon, color: Colors.white, size: iconSize);
      case flick:
        return Icon(
          WhatsevrIcons.flicksIcon001,
          color: Colors.white,
          size: iconSize,
        );
      case offer:
        return Icon(
          WhatsevrIcons.offerIcon,
          color: Colors.white,
          size: iconSize,
        );
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (tileType == wtv) {
          AppNavigationService.newRoute(
            RoutesName.wtvDetails,
            extras: WtvDetailsPageArgument(videoPostUid: uid),
          );
          return;
        }
        // if (tileType == flick) {
        //   AppNavigationService.newRoute(RoutesName.flickDetails,
        //   extras: FlickDetailsPageArgument(flickPostUid: uid),
        //   );
        //   return;
        // }
        // if (tileType == offer) {
        //   AppNavigationService.newRoute(RoutesName.offerDetails,
        //   extras: OfferDetailsPageArgument(offerPostUid: uid),
        //   );
        //   return;
        // }
        // if (tileType == photo) {
        //   AppNavigationService.newRoute(RoutesName.photoDetails,
        //   extras: PhotoDetailsPageArgument(photoPostUid: uid),
        //   );
        //   return;
        // }
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(4.0),
              image: DecorationImage(
                image: ExtendedNetworkImageProvider(
                  thumbnailUrl ??
                      MockData.imagePlaceholder(
                        tileType ?? 'Thumbnail',
                        tileType == flick ? true : false,
                      ),
                  cache: true,
                  printError: true,
                ),
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
