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
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: ExtendedNetworkImageProvider(MockData.randomImageAvatar()),
            ),
            title: Text('User $index'),
            subtitle: Text('Request $index'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 0,
                  ),
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    backgroundColor: WidgetStateProperty.all(Colors.green.withOpacity(0.2)),
                    foregroundColor: WidgetStateProperty.all(Colors.green),
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
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    backgroundColor: WidgetStateProperty.all(Colors.red.withOpacity(0.2)),
                    foregroundColor: WidgetStateProperty.all(Colors.red),
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