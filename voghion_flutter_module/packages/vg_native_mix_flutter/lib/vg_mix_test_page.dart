import 'package:flutter/material.dart';
import 'package:vg_native_mix_flutter/vg_mix_app_home_page.dart';
import 'package:vg_native_mix_flutter/vg_no_animation_route.dart';

class HqMixTestPage extends StatefulWidget {
  const HqMixTestPage({super.key});

  @override
  State<HqMixTestPage> createState() => _HqTestPageState();
}

class _HqTestPageState extends State<HqMixTestPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: VgMixAppHomePage(
        onPageChanged: (pageName, fromNativeOpen, args) {
          return VgNoAnimationRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(title: Text(pageName)),
              body: Center(child: Text('$pageName $fromNativeOpen $args')),
            ),
          );
        },
      ),
    );
  }
}
