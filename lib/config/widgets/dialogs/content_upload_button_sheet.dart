import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fa6_solid.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/pepicons.dart';
import 'package:whatsevr_app/config/widgets/whatsevr_icons.dart';

import 'package:whatsevr_app/src/features/create_posts/create_flick_post/views/page.dart';
import 'package:whatsevr_app/src/features/create_posts/create_memory/views/page.dart';
import 'package:whatsevr_app/src/features/create_posts/create_offer/views/page.dart';
import 'package:whatsevr_app/src/features/create_posts/create_photo_post/views/page.dart';
import 'package:whatsevr_app/src/features/create_posts/create_video_post/views/page.dart';
import 'package:whatsevr_app/src/features/create_posts/upload_pdf/views/page.dart';
import 'package:whatsevr_app/config/enums/post_creator_type.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';
import 'package:whatsevr_app/config/widgets/dialogs/showAppModalSheet.dart';

void showContentUploadBottomSheet(
  BuildContext context, {
  required EnumPostCreatorType postCreatorType,
  String? communityUid,
}) {
  showAppModalSheet(
    context: context,
    flexibleSheet: false,
    child: _Ui(
      postCreatorType: postCreatorType,
      communityUid: communityUid,
    ),
  );
}

class _Ui extends StatelessWidget {
  final EnumPostCreatorType postCreatorType;
  final String? communityUid;
  const _Ui({
    required this.postCreatorType,
    this.communityUid,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Upload Content for ${postCreatorType.value}',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
          ),
          const Gap(16),
          _buildButton(
            icon: const Icon(WhatsevrIcons.postMemories),
            label: 'Create Memory',
            onPressed: () {
              Navigator.pop(context);
              AppNavigationService.newRoute(
                RoutesName.createMemory,
                extras: CreateMemoryPageArgument(
                  postCreatorType: postCreatorType,
                  communityUid: communityUid,
                ),
              );
            },
          ),
          const Gap(8),
          _buildButton(
            icon: Icon(WhatsevrIcons.uploadPhoto),
            label: 'Upload Photos',
            onPressed: () {
              Navigator.pop(context);
              AppNavigationService.newRoute(
                RoutesName.createPhotoPost,
                extras: CreatePhotoPostPageArgument(
                  postCreatorType: postCreatorType,
                  communityUid: communityUid,
                ),
              );
            },
          ),
          const Gap(8),
          _buildButton(
            icon: Icon(WhatsevrIcons.wtvIcon),
            label: 'Create Wtv Post',
            onPressed: () {
              Navigator.pop(context);
              AppNavigationService.newRoute(
                RoutesName.createVideoPost,
                extras: CreateVideoPostPageArgument(
                  postCreatorType: postCreatorType,
                  communityUid: communityUid,
                ),
              );
            },
          ),
          ...[
            const Gap(8),
            _buildButton(
              icon: Icon(WhatsevrIcons.flicksIcon001),
              label: 'Create Flick',
              onPressed: () {
                Navigator.pop(context);
                AppNavigationService.newRoute(
                  RoutesName.createFlick,
                  extras: CreateFlickPostPageArgument(
                    postCreatorType: postCreatorType,
                  ),
                );
              },
            ),
          ],
          ...[
            const Gap(8),
            _buildButton(
              icon: Icon(WhatsevrIcons.offerIcon),
              label: 'Create Offer',
              onPressed: () {
                Navigator.pop(context);
                AppNavigationService.newRoute(
                  RoutesName.createOffer,
                  extras: CreateOfferPageArgument(
                    postCreatorType: postCreatorType,
                    communityUid: communityUid,
                  ),
                );
              },
            ),
            const Gap(8),
          ],
          if (postCreatorType == EnumPostCreatorType.PORTFOLIO) ...[
            _buildButton(
              icon: Icon(WhatsevrIcons.pdfIcon),
              label: 'Upload PDF',
              onPressed: () {
                Navigator.pop(context);
                AppNavigationService.newRoute(
                  RoutesName.uploadPdf,
                  extras:
                      UploadPdfPageArgument(postCreatorType: postCreatorType),
                );
              },
            ),
          ],
          const Gap(16),
        ],
      ),
    );
  }

  Widget _buildButton({
    required Widget icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: MaterialButton(
        elevation: 0,
        color: Colors.grey[100],
        hoverColor: Colors.grey[200],
        highlightColor: Colors.grey[300],
        splashColor: Colors.grey[200],
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.grey[300]!),
        ),
        onPressed: onPressed,
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: IconTheme(
                data: const IconThemeData(
                  size: 18,
                  color: Colors.black87,
                ),
                child: icon,
              ),
            ),
            const Gap(12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
