import 'vg_native_mix_flutter_platform_interface.dart';

class VgNativeMixFlutter {
  static final methodChannelName = 'vg_native_mix_flutter';
  Future<String?> getPlatformVersion() {
    return VgNativeMixFlutterPlatform.instance.getPlatformVersion();
  }

  Future<bool?> closeFlutterPage() {
    return VgNativeMixFlutterPlatform.instance.closeFlutterPage();
  }

  Future<bool?> openNativePage() {
    return VgNativeMixFlutterPlatform.instance.openNativePage();
  }

  Future<bool?> openNativePageWithArgs({
    required String routeName,
    Map<String?, dynamic>? args = const {},
  }) {
    return VgNativeMixFlutterPlatform.instance.openNativePageWithArgs(
      routeName: routeName,
      args: args,
    );
  }

  Future<bool?> closeFlutterPageWithArgs({
    required String routeName,
    Map<String?, dynamic>? args = const {},
  }) {
    return VgNativeMixFlutterPlatform.instance.closeFlutterPageWithArgs(
      routeName: routeName,
      args: args,
    );
  }

  void refreshFlutterPage({
    required String routerName,
    Map<String?, dynamic>? args = const {},
  }) {}
}
