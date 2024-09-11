import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LabelContainer extends StatelessWidget {
  final Widget child;
  final String labelText;
  final bool showBorder;
  const LabelContainer({
    super.key,
    required this.child,
    required this.labelText,
    this.showBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    labelText,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  Gap(8),
                  Icon(
                    Icons.arrow_drop_down_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: showBorder ? Border.all(color: Colors.black) : null,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: child,
            ),
          ],
        ));
  }
}
