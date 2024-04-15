import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/charm.dart';
import 'package:iconify_flutter/icons/ion.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/ph.dart';

import '../../mocks/mocks.dart';
import '../animated_like_icon_button.dart';
import '../feed_players/wtv_player.dart';
import '../pad_horizontal.dart';

class VideoFrame extends StatelessWidget {
  const VideoFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WTVFeedPlayer(
          videoUrl: MockData.demoVideo,
        ),
        const Gap(8),
        PadHorizontal(
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(MockData.randomImageAvatar()),
                  ),
                  const Gap(8),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Short Fast Video Performance Test',
                        ),
                        Gap(4),
                        Text(
                          'Lorem ipsum TV: 2.5M views | 2 days ago',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(8),
              Row(
                children: [
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
