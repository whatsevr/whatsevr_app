import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/widgets/showAppModalSheet.dart';
import 'package:whatsevr_app/config/widgets/super_textform_field.dart';
import 'package:whatsevr_app/generated/assets.dart';

class AiButton extends StatelessWidget {
  final bool showLabel;
  const AiButton({super.key, this.showLabel = false});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showAppModalSheet(context: context, child: const _Ui());
      },
      icon: Row(
        children: <Widget>[
          if (showLabel) ...<Widget>[
            const Text('AI'),
            const Gap(3),
          ],
          ExtendedImage.asset(
            Assets.imagesGeminiSparkleRed,
            width: 20,
            height: 20,
          ),
        ],
      ),
    );
  }
}

class _Ui extends StatelessWidget {
  const _Ui();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        WhatsevrFormField.multilineTextField(
          minLines: 2,
          maxLines: 15,
          maxLength: 500,
        ),
        MaterialButton(
          minWidth: double.infinity,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          color: Colors.blue,
          onPressed: () {},
          child: const Text('Send', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
