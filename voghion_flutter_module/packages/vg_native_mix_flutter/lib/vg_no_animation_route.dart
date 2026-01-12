import 'package:flutter/material.dart';

class VgNoAnimationRoute<T> extends MaterialPageRoute<T> {
  VgNoAnimationRoute({required super.builder, super.settings});

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child; // 直接返回子 Widget，不应用任何过渡动画
  }
}
