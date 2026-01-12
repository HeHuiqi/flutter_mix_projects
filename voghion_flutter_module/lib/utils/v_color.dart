import 'dart:math';

import 'package:flutter/material.dart';

class VColor {
  // 颜色常量
  static const Color primaryColor = Color(0xFFFE284D);
  static const Color greyColor = Color(0xFF999999);
  static const Color blackColor = Color(0xFF333333);

  static const Color scaffoldBackgroundColor = Color(0xFFF8F8F8);
  static const Color dividerColor = Color(0xFFF0F0F0);

  static Color getColor(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    hexColor = hexColor.toUpperCase().replaceAll("0x", "");
    hexColor = hexColor.toUpperCase().replaceAll("0X", "");

    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  static Color getColorWithAlpha(String hexColor, int alpha) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    hexColor = hexColor.toUpperCase().replaceAll("0x", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return Color(int.parse(hexColor, radix: 16) | (alpha << 24));
  }

  static Color getColorWithOpacity(String hexColor, double opacity) {
    return getColorWithAlpha(hexColor, (opacity * 255).toInt());
  }

  // 随机颜色
  static Color getRandomColor() {
    return Color(
      (Random().nextDouble() * 0xFFFFFF).toInt() << 0,
    ).withAlpha(255);
  }
}
