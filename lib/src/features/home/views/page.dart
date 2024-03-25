import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100.0,
            child: Builder(builder: (context) {
              List<Widget> children = [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.primaries[0],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  width: 100.0,
                  alignment: Alignment.center,
                  child: Icon(Icons.add),
                ),
                for (int i = 0; i < 5; i++)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.primaries[i % Colors.primaries.length],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    width: 180.0,
                    alignment: Alignment.center,
                  ),
              ];
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: index == 0 ? PadHorizontal.padding : 0.0,
                        right: index == children.length - 1 ? PadHorizontal.padding : 0.0),
                    child: children[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return Gap(5.0);
                },
                itemCount: children.length,
              );
            }),
          ),
          Gap(8.0),
          Expanded(
              child: PadHorizontal(
            child: WaterfallFlow.builder(
              //cacheExtent: 0.0,

              gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.primaries[index % Colors.primaries.length],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  height: 100.0 + Random().nextInt(300).toDouble(),
                  alignment: Alignment.center,
                );
              },
            ),
          ))
        ],
      ),
    );
  }
}
