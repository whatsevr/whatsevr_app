import 'package:flutter/material.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';

import '../../../../../../../config/mocks/mocks.dart';

class ExplorePageMemoriesPage extends StatelessWidget {
  const ExplorePageMemoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PadHorizontal(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
          childAspectRatio: 3 / 5,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.primaries[index % Colors.primaries.length],
                  borderRadius: BorderRadius.circular(18.0),
                  image: DecorationImage(
                    image: NetworkImage(
                      MockData.randomImage(),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                alignment: Alignment.center,
              ),

              /// profile avatar
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.all(3.0),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 24.0,
                    backgroundImage: NetworkImage(
                      MockData.randomImageAvatar(),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(18.0),
                      bottomRight: Radius.circular(18.0),
                    ),
                  ),
                  child: Text(
                    'User $index',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
