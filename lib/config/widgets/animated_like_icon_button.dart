import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class AnimatedLikeIconButton extends StatelessWidget {
  final double? size;
  const AnimatedLikeIconButton({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: LikeButton(
        size: size ?? 24,
      ),
    );
  }
}
