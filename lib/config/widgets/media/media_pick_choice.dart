import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent_emoji_high_contrast.dart';
import 'package:iconify_flutter/icons/majesticons.dart';
import 'package:iconify_flutter/icons/wpf.dart';
import 'package:whatsevr_app/config/widgets/showAppModalSheet.dart';

showWhatsevrMediaPickerChoice(
    {Function? onChoosingCamera, Function? onChoosingGallery}) {
  showAppModalSheet(
      draggableScrollable: false,
      child: _Ui(
        onChoosingCamera: onChoosingCamera,
        onChoosingGallery: onChoosingGallery,
      ));
}

class _Ui extends StatelessWidget {
  final Function? onChoosingCamera;
  final Function? onChoosingGallery;

  const _Ui({Key? key, this.onChoosingCamera, this.onChoosingGallery})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (onChoosingCamera != null)
            ListTile(
              onTap: () {
                Navigator.pop(context);
                if (onChoosingCamera != null) onChoosingCamera!();
              },
              title: Text('Camera', style: TextStyle(color: Colors.black)),
              leading: Iconify(Wpf.camera),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xff51C5DD),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.shield_moon_outlined,
                              color: Colors.white, size: 13),
                          Text(
                            'Benifit: ShotOnLive tag',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          if (onChoosingGallery != null)
            ListTile(
              onTap: () {
                Navigator.pop(context);
                if (onChoosingGallery != null) onChoosingGallery!();
              },
              title: Text('Gallery'),
              leading: Iconify(Majesticons.device_mobile),
            ),
        ],
      ),
    );
  }
}
