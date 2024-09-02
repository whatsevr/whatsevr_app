import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../../../config/mocks/mocks.dart';

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
                  constraints: const BoxConstraints(
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
                  constraints: const BoxConstraints(
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