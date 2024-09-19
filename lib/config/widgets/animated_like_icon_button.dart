import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ant_design.dart';


class AnimatedLikeIconButton extends StatelessWidget {
  final double? size;
  const AnimatedLikeIconButton({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: LikeButton(
        size: size ?? 24,
        likeBuilder: (bool isLiked) {
          return Iconify(
            isLiked ? AntDesign.heart_filled : AntDesign.heart_outlined,
            color: isLiked ? Colors.red : Colors.black,
          );
        },
      ),
    );
  }
}
