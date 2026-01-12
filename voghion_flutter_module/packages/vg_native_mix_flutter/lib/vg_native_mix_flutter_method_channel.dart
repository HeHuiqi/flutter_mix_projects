import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'vg_native_mix_flutter_platform_interface.dart';

/// An implementation of [VgNativeMixFlutterPlatform] that uses method channels.
class MethodChannelVgNativeMixFlutter extends VgNativeMixFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('vg_native_mix_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }

  @override
  Future<bool?> closeFlutterPage() async {
    final res = await methodChannel.invokeMethod<bool>('closeFlutterPage');
    return res;
  }

  @override
  Future<bool?> openNativePage() async {
    final res = await methodChannel.invokeMethod<bool>('openNativePage');
    return res;
  }

  @override
  Future<bool?> openNativePageWithArgs({
    String? routeName,
    Map<String?, dynamic>? args = const {},
  }) async {
    final res = await methodChannel.invokeMethod<bool>('openNativePage', {
      'routeName': routeName,
      'args': args,
    });
    return res;
  }

  @override
  Future<bool?> closeFlutterPageWithArgs({
    String? routeName,
    Map<String?, dynamic>? args = const {},
  }) async {
    final res = await methodChannel.invokeMethod<bool>('closeFlutterPage', {
      'routeName': routeName,
      'args': args,
    });
    return res;
  }
}
