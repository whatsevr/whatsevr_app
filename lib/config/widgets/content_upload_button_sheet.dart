import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fa6_solid.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/pepicons.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';
import 'package:whatsevr_app/src/features/create_posts/create_video_post/views/page.dart';

import 'package:whatsevr_app/config/enums/post_creator_type.dart';

import '../../src/features/create_posts/create_flick_post/views/page.dart';

void showContentUploadBottomSheet(
  BuildContext context, {
  required EnumPostCreatorType postCreatorType,
}) {
  showModalBottomSheet(
    useRootNavigator: true,
    barrierColor: Colors.white.withOpacity(0.5),
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    builder: (BuildContext context) {
      return _Ui(
        postCreatorType: postCreatorType,
      );
    },
  );
}

class _Ui extends StatelessWidget {
  final EnumPostCreatorType postCreatorType;
  const _Ui({
    required this.postCreatorType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
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
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                allowMultiple: true,
                type: FileType.media,
              );
            },
            child: const Row(
              children: <Widget>[
                Iconify(Ic.round_history_toggle_off),
                Gap(8),
                Text('Upload Memories'),
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
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                allowMultiple: true,
                type: FileType.image,
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
                Text('Upload Wtv Video'),
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
              AppNavigationService.newRoute(
                RoutesName.createFlickPost,
                extras: CreateFlickPostPageArgument(
                  postCreatorType: postCreatorType,
                ),
              );
            },
            child: const Row(
              children: <Widget>[
                Iconify(Pepicons.play_print),
                Gap(8),
                Text('Upload Flick'),
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
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  allowMultiple: true,
                  type: FileType.video,
                );
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
      ),
    );
  }
}
