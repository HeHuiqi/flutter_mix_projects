import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'vg_native_mix_flutter_method_channel.dart';

abstract class VgNativeMixFlutterPlatform extends PlatformInterface {
  /// Constructs a VgNativeMixFlutterPlatform.
  VgNativeMixFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static VgNativeMixFlutterPlatform _instance =
      MethodChannelVgNativeMixFlutter();

  /// The default instance of [VgNativeMixFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelVgNativeMixFlutter].
  static VgNativeMixFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [VgNativeMixFlutterPlatform] when
  /// they register themselves.
  static set instance(VgNativeMixFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool?> closeFlutterPage() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool?> openNativePage() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool?> closeFlutterPageWithArgs({
    String? routeName,
    Map<String?, dynamic>? args = const {},
  }) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool?> openNativePageWithArgs({
    String? routeName,
    Map<String?, dynamic>? args = const {},
  }) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
