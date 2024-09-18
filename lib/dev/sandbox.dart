import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:whatsevr_app/config/api/external/models/similar_place_by_query.dart'
    hide PlaceName;
import 'package:whatsevr_app/config/services/location.dart';
import 'package:whatsevr_app/config/widgets/media/asset_picker.dart'; // Assuming this is where CustomAssetPicker is
import 'package:video_player/video_player.dart';

import 'package:whatsevr_app/config/widgets/media/aspect_ratio.dart';
import 'package:whatsevr_app/config/widgets/showAppModalSheet.dart';

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
          for ((String, Future<void>? Function()) itm
              in <(String, Future<void>? Function())>[
            (
              'Test1',
              () async {
                LocationService.getNearByPlacesFromLatLong(
                  onCompleted: (nearbyPlacesResponse, lat, long,
                      isDeviceGpsEnabled, isPermissionAllowed) {
                    if (nearbyPlacesResponse == null) {
                      if (!isDeviceGpsEnabled) {
                        SmartDialog.showToast('Please enable GPS');
                      } else if (!isPermissionAllowed) {
                        SmartDialog.showToast(
                            'Please allow location permission');
                      }
                      return;
                    } else {
                      SmartDialog.showToast(
                          '${nearbyPlacesResponse.places!.length}');
                    }
                  },
                );
              }
            ),
            ('Test2', () async {}),
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
