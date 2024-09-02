import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PortfolioPageAboutView extends StatelessWidget {
  const PortfolioPageAboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(12),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(8),
                  Text('Status',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  Text('Lorem ipsum dolor sit amet, consectetur adipiscinquam.',
                      style: TextStyle(fontSize: 16)),
                  Gap(8),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(8),
                  Text('Serve',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  Text('Lorem ipsum dolor sit amet, consectetur adipiscinquam.',
                      style: TextStyle(fontSize: 16)),
                  Gap(8),
                ],
              ),
            ),
          ),
        ),
        for ((String label, String info) itm in <(String, String)>[
          ('Bio', 'XXXXXXXXXXXXXXXXXXXXXXXXXXX'),
          ('Address', 'XXXXXXXXXXXXXXXXXXXXXXXXXX'),
          ('Education', 'XXXXXXXXXXXXXXXXXXXXXX'),
          ('Working', 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'),
          ('Email', 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'),
          ('Birthday', 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'),
          ('Join On', 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'),
          ('Portfolio link', 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'),
          ('Total Connection', 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'),
          ('Total Views', '2524'),
          ('Add info', 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'),
        ])
          CheckboxListTile(
            visualDensity: VisualDensity.compact,
            controlAffinity: ListTileControlAffinity.leading,
            checkColor: Colors.white,
            activeColor: Colors.black,
            value: false,
            onChanged: (bool? value) {},
            title: Text(
              itm.$1,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              itm.$2,
              style: const TextStyle(fontSize: 12),
            ),
            isThreeLine: true,
          ),
      ],
    );
  }
}
