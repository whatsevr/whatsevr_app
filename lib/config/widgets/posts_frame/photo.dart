import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/charm.dart';
import 'package:iconify_flutter/icons/ion.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/ph.dart';

import '../../mocks/mocks.dart';
import '../animated_like_icon_button.dart';
import '../pad_horizontal.dart';

class PhotoFrame extends StatelessWidget {
  const PhotoFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PadHorizontal(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(MockData.randomImageAvatar()),
                  ),
                  const Gap(8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username',
                        ),
                        Gap(2),
                        Text(
                          '30 minutes ago',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Gap(8),
              Text(
                'Photo Caption goes here',
              ),
            ],
          ),
        ),
        const Gap(8),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: ExtendedImage.network(
            MockData.randomImage(),
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
        ),
        PadHorizontal(
          child: Column(
            children: [
              Row(
                children: [
                  AnimatedLikeIconButton(),
                  Text('2.5M'),
                  IconButton(
                    icon: Iconify(Ph.chat_centered_dots),
                    onPressed: () {},
                  ),
                  Text('2.5M'),
                  IconButton(
                    icon: Iconify(MaterialSymbols.ios_share),
                    onPressed: () {},
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Iconify(Ion.bookmark),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Iconify(Charm.menu_kebab),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
