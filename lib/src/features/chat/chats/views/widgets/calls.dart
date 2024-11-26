import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:whatsevr_app/config/mocks/mocks.dart';

class ChatsPageCallsView extends StatelessWidget {
  const ChatsPageCallsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: 20,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            dense: true,
            visualDensity: VisualDensity.compact,
            leading: CircleAvatar(
              backgroundImage:
                  ExtendedNetworkImageProvider(MockData.randomImageAvatar()),
            ),
            title: Text('User $index'),
            subtitle: Row(
              children: <Widget>[
                Text('Call $index'),
                const Gap(8),
                const Text('12:00'),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.call),
              onPressed: () {},
            ),
          );
        },
      ),
    );
  }
}
