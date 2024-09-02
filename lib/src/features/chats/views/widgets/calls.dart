import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../config/mocks/mocks.dart';

class ChatsPageCallsView extends StatelessWidget {
  const ChatsPageCallsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: 20,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: ExtendedNetworkImageProvider(MockData.randomImageAvatar()),
            ),
            title: Text('User $index'),
            subtitle: Row(
              children: [
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