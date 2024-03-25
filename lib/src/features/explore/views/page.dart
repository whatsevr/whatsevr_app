import 'package:animated_hint_textfield/animated_hint_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/charm.dart';
import 'package:iconify_flutter/icons/ion.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/ph.dart';

import '../../../../config/mocks/mocks.dart';
import '../../../../config/widgets/pad_horizontal.dart';
import '../../dashboard/views/widgets/feed_player.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(8),
        PadHorizontal(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(Icons.search),
                const Gap(8),
                Expanded(
                  child: AnimatedTextField(
                    animationType:
                        Animationtype.slide, // Use Animationtype.slide for Slide animations

                    decoration: InputDecoration.collapsed(
                      hintText: '',
                    ),
                    hintTexts: [
                      'Search for "Posts"',
                      'Search for "Profile"',
                      'Search for "Fliks"',
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const Gap(8),
        SizedBox(
          height: 35,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: [
              Gap(8),
              for ((String label,) item in [
                ('Wtv',),
                ('Media',),
                ('Trending',),
                ('Memories',),
              ])
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(item.$1,
                      style: TextStyle(
                        fontWeight: item.$1 == 'Wtv' ? FontWeight.bold : null,
                      )),
                ),
              Gap(8),
            ],
          ),
        ),
        const Gap(8),
        Expanded(
          child: ListView(
            children: [
              Column(
                children: [
                  WTVFeedPlayer(
                    videoUrl:
                        'https://firebasestorage.googleapis.com/v0/b/whatsevr-dev.appspot.com/o/demos%2FAMPLIFIER%20x%20PUBG%20MOBILE%20MONTAGE%20(ULTRA%20HD)%20_%2069%20JOKER.mp4?alt=media&token=580b20c1-a339-4802-9c60-7379b0917ea3',
                  ),
                  const Gap(8),
                  PadHorizontal(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(MockData.imageAvatar),
                            ),
                            const Gap(8),
                            Expanded(
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
                            IconButton(
                              icon: const Icon(Icons.favorite),
                              color: Colors.red,
                              onPressed: () {},
                            ),
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
              ),
              const Gap(50),
              Center(child: CircularProgressIndicator()),
              const Gap(50),
            ],
          ),
        ),
      ],
    );
  }
}
