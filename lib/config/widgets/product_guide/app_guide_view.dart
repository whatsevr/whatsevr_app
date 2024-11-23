import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AppGuideView extends StatelessWidget {
  final String? headingTitle;
  final List<Widget>? guides;
  const AppGuideView({super.key, this.guides, this.headingTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          headingTitle ?? 'Guides',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
              child: guides![index],
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Gap(10);
          },
          itemCount: guides!.length,
        ),
      ],
    );
  }
}
