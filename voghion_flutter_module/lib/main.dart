import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:vg_native_mix_flutter/vg_404_page.dart';
import 'package:vg_native_mix_flutter/vg_mix_app_home_page.dart';
import 'package:vg_native_mix_flutter/vg_no_animation_route.dart';
import 'package:voghion_flutter_module/pages/home/v_home_page.dart';
import 'package:voghion_flutter_module/theme/v_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: 'Flutter',
        theme: VTheme.lightTheme,
        home: VgMixAppHomePage(
          onPageChanged: (routeName, fromNativeOpen, args) {
            if (routeName == '/flutter_home') {
              return VgNoAnimationRoute(
                builder: (context) {
                  return VHomePage(fromNativeOpen: fromNativeOpen);
                },
              );
            }
            if (routeName == 'product') {
              return VgNoAnimationRoute(
                builder: (context) {
                  return Vg404Page();
                },
              );
            }
            return null;
          },
        ),
      ),
    );
  }
}
