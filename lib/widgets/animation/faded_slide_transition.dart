import 'package:flutter/material.dart';

class FadedSlideTransition extends StatelessWidget {
  final Animation<double> animation;
  final Tween<Offset>? positionTween;
  final Widget? child;

  const FadedSlideTransition({
    Key? key,
    required this.animation,
    this.child,
    this.positionTween,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Tween<Offset> tween = positionTween ??
        Tween<Offset>(
          begin: const Offset(0.0, 1.0),
          end: Offset.zero,
        );
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: tween.animate(animation),
        child: child,
      ),
    );
  }
}
