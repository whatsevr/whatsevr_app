import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/charm.dart';
import 'package:iconify_flutter/icons/ion.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/ph.dart';

import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/widgets/animated_like_icon_button.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';

class PhotoFrame extends StatelessWidget {
  const PhotoFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        PadHorizontal(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(MockData.randomImageAvatar()),
                  ),
                  const Gap(8),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
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
              const Gap(8),
              const Text(
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
            children: <Widget>[
              Row(
                children: <Widget>[
                  const AnimatedLikeIconButton(),
                  const Text('2.5M'),
                  IconButton(
                    icon: const Iconify(Ph.chat_centered_dots),
                    onPressed: () {},
                  ),
                  const Text('2.5M'),
                  IconButton(
                    icon: const Iconify(MaterialSymbols.ios_share),
                    onPressed: () {},
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Iconify(Ion.bookmark),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Iconify(Charm.menu_kebab),
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
