import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vg_native_mix_flutter/vg_native_mix_flutter_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelVgNativeMixFlutter platform = MethodChannelVgNativeMixFlutter();
  const MethodChannel channel = MethodChannel('vg_native_mix_flutter');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
