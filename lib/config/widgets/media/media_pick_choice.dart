import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';

import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/mdi.dart';

import 'package:whatsevr_app/config/widgets/showAppModalSheet.dart';

showWhatsevrMediaPickerChoice({
  Function? onChoosingImageFromCamera,
  Function? onChoosingImageFromGallery,
  Function? onChoosingVideoFromCamera,
  Function? onChoosingVideoFromGallery,
}) {
  showAppModalSheet(
      flexibleSheet: false,
      child: _Ui(
        onChoosingImageFromCamera: onChoosingImageFromCamera,
        onChoosingImageFromGallery: onChoosingImageFromGallery,
        onChoosingVideoFromCamera: onChoosingVideoFromCamera,
        onChoosingVideoFromGallery: onChoosingVideoFromGallery,
      ));
}

class _Ui extends StatelessWidget {
  final Function? onChoosingImageFromCamera;
  final Function? onChoosingImageFromGallery;
  final Function? onChoosingVideoFromCamera;
  final Function? onChoosingVideoFromGallery;

  const _Ui(
      {this.onChoosingImageFromCamera,
      this.onChoosingImageFromGallery,
      this.onChoosingVideoFromCamera,
      this.onChoosingVideoFromGallery});

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
          if (onChoosingImageFromCamera != null)
            ListTile(
              onTap: () {
                Navigator.pop(context);
                onChoosingImageFromCamera?.call();
              },
              title: const Text('Capture Image',
                  style: TextStyle(color: Colors.black)),
              leading: const Iconify(Ic.baseline_camera),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xff51C5DD),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.shield_moon_outlined,
                              color: Colors.white, size: 13),
                          Text(
                            'Benefit: ShotOnLive tag',
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
          if (onChoosingImageFromGallery != null)
            ListTile(
              onTap: () {
                Navigator.pop(context);
                onChoosingImageFromGallery?.call();
              },
              title: const Text('Pick Image'),
              leading: const Iconify(Mdi.image_search),
            ),
          if (onChoosingVideoFromCamera != null)
            ListTile(
              onTap: () {
                Navigator.pop(context);
                onChoosingVideoFromCamera?.call();
              },
              title: const Text('Capture Video',
                  style: TextStyle(color: Colors.black)),
              leading: const Iconify(Mdi.camcorder),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xff51C5DD),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.shield_moon_outlined,
                              color: Colors.white, size: 13),
                          Text(
                            'Benefit: ShotOnLive tag',
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
          if (onChoosingVideoFromGallery != null)
            ListTile(
              onTap: () {
                Navigator.pop(context);
                onChoosingVideoFromGallery?.call();
              },
              title: const Text('Pick Video'),
              leading: const Iconify(MaterialSymbols.video_library_rounded),
            ),
        ],
      ),
    );
  }
}
