import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';

class ChatsPageGroupsView extends StatelessWidget {
  const ChatsPageGroupsView({
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
            leading: CircleAvatar(
              backgroundImage: ExtendedNetworkImageProvider(MockData.randomImage()),
            ),
            title: Text('Group $index'),
            subtitle: Text('User: Message $index'),
            trailing: const Text('12:00'),
          );
        },
      ),
    );
  }
}