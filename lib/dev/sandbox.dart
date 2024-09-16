import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:whatsevr_app/config/widgets/media/asset_picker.dart'; // Assuming this is where CustomAssetPicker is
import 'package:video_player/video_player.dart';

import 'package:whatsevr_app/config/widgets/media/aspect_ratio.dart';

class DeveloperPage extends StatefulWidget {
  const DeveloperPage({super.key});

  @override
  State<DeveloperPage> createState() => _DeveloperPageState();
}

class _DeveloperPageState extends State<DeveloperPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sandbox'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          // Buttons for different actions
          for ((String, Future<void>? Function()) itm
              in <(String, Future<void>? Function())>[
            (
              'Test',
              () {
                SmartDialog.showToast('Test');
              }
            ),
            ('Pick Images', () {}),
            ('Pick Videos', () {}),
            ('Pick Documents', () {}),
          ])
            TextButton(
              onPressed: itm.$2,
              child: Text(itm.$1),
            ),
        ],
      ),
    );
  }
}
