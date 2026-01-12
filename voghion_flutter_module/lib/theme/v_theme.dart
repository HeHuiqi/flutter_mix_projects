import 'package:flutter/material.dart';
import 'package:voghion_flutter_module/utils/v_color.dart';

class VTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: VColor.primaryColor,
    brightness: Brightness.light,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: VColor.primaryColor,
    ),
    dividerColor: VColor.dividerColor,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0,
      centerTitle: true,
    ),
    scaffoldBackgroundColor: VColor.scaffoldBackgroundColor,

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: VColor.primaryColor,
      unselectedItemColor: Colors.grey,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.blue, // 显式设置光标颜色
      selectionColor: Colors.blue.withAlpha(76), // 显式设置选择颜色
      selectionHandleColor: Colors.blue, // 显式设置选择手柄颜色
    ),
  );
  static final ThemeData darkTheme = ThemeData(
    primaryColor: Colors.blue,
    brightness: Brightness.dark,
  );
}
