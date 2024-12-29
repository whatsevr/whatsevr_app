part of '../page.dart';

class _MixContentView extends StatelessWidget {
  const _MixContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      itemCount: 40,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        String tileType=[
          WhatsevrMixPostTile.photo,
          WhatsevrMixPostTile.video,
          WhatsevrMixPostTile.flick,
          WhatsevrMixPostTile.offer,
        ][Random().nextInt(4)];
        return Container(
          color: Colors.blue,
          height: tileType == WhatsevrMixPostTile.flick ? 250 : 100,
          child: WhatsevrMixPostTile(
            tileType: tileType,

          ),
        );
      },
    );
  }
}
