import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
import 'package:whatsevr_app/config/widgets/tab_bar.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const PadHorizontal(
            child: Text(
              'Notifications',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Gap(8),
          const DefaultTabController(
            length: 3,
            child: WhatsevrTabBar(
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              tabs: <String>[
                'All',
                'Comments',
                'Tags/mentions',
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (index == 0 || index == 3 || index == 6)
                      PadHorizontal(
                        child: Text(
                          index == 0
                              ? 'Today'
                              : index == 3
                                  ? 'Yesterday'
                                  : index == 6
                                      ? 'Last week'
                                      : '',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ListTile(
                      visualDensity: VisualDensity.compact,
                      leading: CircleAvatar(
                        radius: 24,
                        backgroundImage: ExtendedNetworkImageProvider(
                          MockData.randomImageAvatar(),
                        ),
                      ),
                      title: const Text(
                        'Mr John Doe, liked your post XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
                      ),
                      trailing: const Icon(Icons.more_vert),
                    ),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Gap(8);
              },
              itemCount: 30,
            ),
          ),
        ],
      ),
    );
  }
}
