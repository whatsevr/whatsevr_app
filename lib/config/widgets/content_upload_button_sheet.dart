import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fa6_solid.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/pepicons.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';
import 'package:whatsevr_app/config/widgets/showAppModalSheet.dart';
import 'package:whatsevr_app/src/features/create_posts/create_video_post/views/page.dart';

import 'package:whatsevr_app/config/enums/post_creator_type.dart';

import '../../src/features/create_posts/create_flick_post/views/page.dart';
import '../../src/features/create_posts/create_memory/views/page.dart';
import '../../src/features/create_posts/create_offer/views/page.dart';
import '../../src/features/create_posts/create_photo_post/views/page.dart';

void showContentUploadBottomSheet(
  BuildContext context, {
  required EnumPostCreatorType postCreatorType,
}) {
  showAppModalSheet(
    context: context,
    draggableScrollable: true,
    child: _Ui(
      postCreatorType: postCreatorType,
    ),
  );
}

class _Ui extends StatelessWidget {
  final EnumPostCreatorType postCreatorType;
  const _Ui({
    required this.postCreatorType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Gap(20),
        Text(
          'Upload Content for ${postCreatorType.value}',
        ),
        const Gap(20),
        MaterialButton(
          elevation: 0,
          color: Colors.blueGrey.withOpacity(0.2),
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: () async {
            Navigator.pop(context);
            AppNavigationService.newRoute(
              RoutesName.createMemory,
              extras: CreateMemoryPageArgument(
                postCreatorType: postCreatorType,
              ),
            );
          },
          child: const Row(
            children: <Widget>[
              Iconify(Ic.round_history_toggle_off),
              Gap(8),
              Text('Post Memories'),
            ],
          ),
        ),
        const Gap(8),
        MaterialButton(
          elevation: 0,
          color: Colors.blueGrey.withOpacity(0.2),
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: () async {
            Navigator.pop(context);
            AppNavigationService.newRoute(
              RoutesName.createPhotoPost,
              extras: CreatePhotoPostPageArgument(
                postCreatorType: postCreatorType,
              ),
            );
          },
          child: const Row(
            children: <Widget>[
              Iconify(Mdi.camera_image),
              Gap(8),
              Text('Upload Photo'),
            ],
          ),
        ),
        const Gap(8),
        MaterialButton(
          elevation: 0,
          color: Colors.blueGrey.withOpacity(0.2),
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: () async {
            Navigator.pop(context);
            AppNavigationService.newRoute(
              RoutesName.createVideoPost,
              extras: CreateVideoPostPageArgument(
                postCreatorType: postCreatorType,
              ),
            );
          },
          child: const Row(
            children: <Widget>[
              Iconify(Ic.sharp_slow_motion_video),
              Gap(8),
              Text('Create Wtv Video'),
            ],
          ),
        ),
        const Gap(8),
        MaterialButton(
          elevation: 0,
          color: Colors.blueGrey.withOpacity(0.2),
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: () async {
            Navigator.pop(context);
            AppNavigationService.newRoute(
              RoutesName.createFlick,
              extras: CreateFlickPostPageArgument(
                postCreatorType: postCreatorType,
              ),
            );
          },
          child: const Row(
            children: <Widget>[
              Iconify(Pepicons.play_print),
              Gap(8),
              Text('Create Flick'),
            ],
          ),
        ),
        if (postCreatorType != EnumPostCreatorType.ACCOUNT) ...<Widget>[
          const Gap(8),
          MaterialButton(
            elevation: 0,
            color: Colors.blueGrey.withOpacity(0.2),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () async {
              Navigator.pop(context);
              AppNavigationService.newRoute(
                RoutesName.createOffer,
                extras: CreateOfferPageArgument(
                  postCreatorType: postCreatorType,
                ),
              );
            },
            child: const Row(
              children: <Widget>[
                Iconify(Fa6Solid.signs_post),
                Gap(8),
                Text('Create Offer'),
              ],
            ),
          ),
        ],
        if (postCreatorType != EnumPostCreatorType.ACCOUNT) ...<Widget>[
          const Gap(8),
          MaterialButton(
            elevation: 0,
            color: Colors.blueGrey.withOpacity(0.2),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () async {
              Navigator.pop(context);
            },
            child: const Row(
              children: <Widget>[
                Iconify(Fa6Solid.file_pdf),
                Gap(8),
                Text('Upload Pdf'),
              ],
            ),
          ),
        ],
        const Gap(8),
      ],
    );
  }
}
