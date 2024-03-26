import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';

///[WhatsApp Style Module - Copilot]
class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        body: Column(
          children: [
            TabBar(
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.black,
              indicatorColor: Colors.black,
              tabs: [
                Tab(
                  text: 'Chats',
                ),
                Tab(
                  text: 'Groups',
                ),
                Tab(
                  text: 'Calls',
                ),
                Tab(
                  text: 'Requests',
                ),
              ],
            ),
            Expanded(
              child: const TabBarView(
                children: [
                  ChatsPageChatView(),
                  ChatsPageGroupView(),
                  Text('Calls'),
                  Text('Requests'),
                ],
              ),
            ),
          ],
        ),
      ),
      length: 4,
    );
  }
}

class ChatsPageGroupView extends StatelessWidget {
  const ChatsPageGroupView({
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
              backgroundImage: ExtendedNetworkImageProvider(MockData.randomImage()),
            ),
            title: Text('Group $index'),
            subtitle: Text('User: Message $index'),
            trailing: Text('12:00'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.group),
      ),
    );
  }
}

class ChatsPageChatView extends StatelessWidget {
  const ChatsPageChatView({
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
            trailing: Text('12:00'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.message),
      ),
    );
  }
}
