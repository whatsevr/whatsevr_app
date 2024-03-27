import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
                  ChatsPageChatsView(),
                  ChatsPageGroupsView(),
                  ChatsPageCallsView(),
                  ChatsPageRequestsView(),
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

class ChatsPageRequestsView extends StatelessWidget {
  const ChatsPageRequestsView({
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
            subtitle: Text('Request $index'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(
                    minWidth: 0,
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.green.withOpacity(0.2)),
                    foregroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  icon: const Icon(Icons.check),
                  onPressed: () {},
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(
                    minWidth: 0,
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.red.withOpacity(0.2)),
                    foregroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  icon: const Icon(Icons.close),
                  onPressed: () {},
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

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
                Gap(8),
                Text('12:00'),
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

class ChatsPageGroupsView extends StatelessWidget {
  const ChatsPageGroupsView({
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
    );
  }
}

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
            trailing: Text('12:00'),
          );
        },
      ),
    );
  }
}
