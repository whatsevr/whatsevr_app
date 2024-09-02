import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';

class ChatsPageChatsView extends StatelessWidget {
  const ChatsPageChatsView({
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
            subtitle: Text('Message $index'),
            trailing: const Text('12:00'),
          );
        },
      ),
    );
  }
}