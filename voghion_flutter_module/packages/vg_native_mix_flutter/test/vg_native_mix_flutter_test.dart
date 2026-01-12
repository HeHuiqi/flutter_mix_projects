import 'package:flutter_test/flutter_test.dart';
import 'package:vg_native_mix_flutter/vg_native_mix_flutter.dart';
import 'package:vg_native_mix_flutter/vg_native_mix_flutter_platform_interface.dart';
import 'package:vg_native_mix_flutter/vg_native_mix_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockVgNativeMixFlutterPlatform
    with MockPlatformInterfaceMixin
    implements VgNativeMixFlutterPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<bool?> closeFlutterPage() {
    // TODO: implement closeFlutterPage
    throw UnimplementedError();
  }

  @override
  Future<bool?> closeFlutterPageWithArgs({
    String? routeName,
    Map<String?, dynamic>? args = const {},
  }) {
    // TODO: implement closeFlutterPageWithArgs
    throw UnimplementedError();
  }

  @override
  Future<bool?> openNativePage() {
    // TODO: implement openNativePage
    throw UnimplementedError();
  }

  @override
  Future<bool?> openNativePageWithArgs({
    String? routeName,
    Map<String?, dynamic>? args = const {},
  }) {
    // TODO: implement openNativePageWithArgs
    throw UnimplementedError();
  }
}

void main() {
  final VgNativeMixFlutterPlatform initialPlatform =
      VgNativeMixFlutterPlatform.instance;

  test('$MethodChannelVgNativeMixFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelVgNativeMixFlutter>());
  });

  test('getPlatformVersion', () async {
    VgNativeMixFlutter vgNativeMixFlutterPlugin = VgNativeMixFlutter();
    MockVgNativeMixFlutterPlatform fakePlatform =
        MockVgNativeMixFlutterPlatform();
    VgNativeMixFlutterPlatform.instance = fakePlatform;

    expect(await vgNativeMixFlutterPlugin.getPlatformVersion(), '42');
  });
}
