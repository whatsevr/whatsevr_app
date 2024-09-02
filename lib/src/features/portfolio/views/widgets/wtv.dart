import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';

class PortfolioPageWtvView extends StatelessWidget {
  const PortfolioPageWtvView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Row(
          children: [
            Stack(
              children: [
                ExtendedImage.network(
                  MockData.randomImage(),
                  borderRadius: BorderRadius.circular(8),
                  shape: BoxShape.rectangle,
                  fit: BoxFit.cover,
                  height: 100,
                  width: 150,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text('10:00',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        )),
                  ),
                ),
              ],
            ),
            const Gap(8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Title XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
                      maxLines: 2,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const Gap(8),
                  Text('2M views . 2 days ago . 122k likes',
                      style: TextStyle(
                        fontSize: 12,
                      )),
                ],
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return Gap(8);
      },
      itemCount: 10,
    );
  }
}
