import 'package:vg_native_mix_flutter/vg_widget_mixin.dart';

class VgNativeCallBacks {
  static final VgNativeCallBacks _instance = VgNativeCallBacks._internal();
  factory VgNativeCallBacks() {
    return _instance;
  }

  VgNativeCallBacks._internal();
  List<VgWidgetMixinRefreshPage> callbacks = [];

  void addCallback(VgWidgetMixinRefreshPage callback) {
    callbacks.add(callback);
  }

  void removeCallback(VgWidgetMixinRefreshPage callback) {
    callbacks.remove(callback);
  }

  void refreshPage({String? routerName, Map<Object?, Object?>? args}) {
    for (var callback in callbacks) {
      callback.refresshPage(routerName: routerName, args: args);
    }
  }
}
