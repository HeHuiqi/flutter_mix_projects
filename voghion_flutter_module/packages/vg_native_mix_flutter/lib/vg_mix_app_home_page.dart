import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vg_native_mix_flutter/vg_404_page.dart';
import 'package:vg_native_mix_flutter/vg_native_call_backs.dart';
import 'package:vg_native_mix_flutter/vg_native_mix_flutter.dart';
import 'package:vg_native_mix_flutter/vg_no_animation_route.dart';

class VgMixAppHomePage extends StatefulWidget {
  const VgMixAppHomePage({super.key, required this.onPageChanged});

  final VgNoAnimationRoute? Function(
    String routeName,
    bool fromNativeOpen,
    Map<Object?, Object?>? args,
  )?
  onPageChanged;

  @override
  State<VgMixAppHomePage> createState() => _VgMixAppHomePageState();
}

class _VgMixAppHomePageState extends State<VgMixAppHomePage> {
  final MethodChannel methodChannel = MethodChannel(
    VgNativeMixFlutter.methodChannelName,
  );
  @override
  void initState() {
    super.initState();
    methodChannel.setMethodCallHandler((call) async {
      debugPrint('call.method:${call.method}');
      debugPrint('call.arguments:${call.arguments}');

      try {
        if (call.method == "push") {
          Map<Object?, Object?>? args =
              (call.arguments as Map<Object?, Object?>?) ?? {};
          if (args['routeName'] != '/' && args['fromNativeOpen'] == true) {
            final route = widget.onPageChanged?.call(
              args['routeName'] as String,
              true,
              args,
            );
            if (route != null) {
              Navigator.of(context).push(route);
            } else {
              Navigator.of(
                context,
              ).push(VgNoAnimationRoute(builder: (context) => Vg404Page()));
            }
          } else {
            debugPrint('not from native open');
          }
        } else if (call.method == "destroyFlutterPages") {
          if (Navigator.canPop(context)) {
            Navigator.popUntil(context, (Route<dynamic> route) {
              return route is VgNoAnimationRoute;
            });
          }
        } else if (call.method == "refreshPage") {
          Map<Object?, Object?>? args =
              (call.arguments as Map<Object?, Object?>?) ?? {};
          String? routerName = args['routerName'] as String?;

          VgNativeCallBacks().refreshPage(routerName: routerName, args: args);
        }
      } catch (e) {
        debugPrint('  page error:$e');
      }
      return "success";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Vg404Page();
  }
}
