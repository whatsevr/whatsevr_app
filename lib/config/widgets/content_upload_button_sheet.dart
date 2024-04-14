import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/pepicons.dart';

showContentUploadBottomSheet(BuildContext context) {
  showModalBottomSheet(
      useRootNavigator: true,
      barrierColor: Colors.white.withOpacity(0.5),
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Gap(20),
                MaterialButton(
                  elevation: 0,
                  color: Colors.blueGrey.withOpacity(0.2),
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () async {
                    FilePickerResult? result = await FilePicker.platform.pickFiles(
                      allowMultiple: true,
                      type: FileType.media,
                    );
                  },
                  child: Row(
                    children: [
                      Iconify(Ic.round_history_toggle_off),
                      const Gap(8),
                      const Text('Upload Memories'),
                    ],
                  ),
                ),
                Gap(8),
                MaterialButton(
                  elevation: 0,
                  color: Colors.blueGrey.withOpacity(0.2),
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () async {
                    FilePickerResult? result = await FilePicker.platform.pickFiles(
                      allowMultiple: true,
                      type: FileType.image,
                    );
                  },
                  child: Row(
                    children: [
                      Iconify(Mdi.camera_image),
                      const Gap(8),
                      const Text('Upload Photo'),
                    ],
                  ),
                ),
                Gap(8),
                MaterialButton(
                  elevation: 0,
                  color: Colors.blueGrey.withOpacity(0.2),
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () async {
                    FilePickerResult? result = await FilePicker.platform.pickFiles(
                      allowMultiple: true,
                      type: FileType.video,
                    );
                  },
                  child: Row(
                    children: [
                      Iconify(Ic.sharp_slow_motion_video),
                      const Gap(8),
                      const Text('Upload Wtv Video'),
                    ],
                  ),
                ),
                Gap(8),
                MaterialButton(
                  elevation: 0,
                  color: Colors.blueGrey.withOpacity(0.2),
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () async {
                    FilePickerResult? result = await FilePicker.platform.pickFiles(
                      allowMultiple: true,
                      type: FileType.video,
                    );
                  },
                  child: Row(
                    children: [
                      Iconify(Pepicons.play_print),
                      const Gap(8),
                      const Text('Upload Flick Video'),
                    ],
                  ),
                ),
                Gap(8),
              ],
            ));
      });
}
