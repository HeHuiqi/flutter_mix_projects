import 'package:flutter/material.dart';
import 'package:vg_native_mix_flutter/vg_native_mix_flutter.dart';

class Vg404Page extends StatelessWidget {
  const Vg404Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter'),
        leading: BackButton(
          onPressed: () {
            VgNativeMixFlutter().closeFlutterPage();
          },
        ),
      ),
      body: Center(
        child: Text('404 Not Found', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
