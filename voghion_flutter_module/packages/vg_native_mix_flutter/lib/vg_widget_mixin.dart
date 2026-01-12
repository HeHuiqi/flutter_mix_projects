import 'package:flutter/material.dart';
import 'package:vg_native_mix_flutter/vg_native_mix_flutter.dart';

mixin VgWidgetMixin {
  // 添加属性（需在使用时实现）
  bool get fromNativeOpen;
}

mixin VgWidgetMixinClosePage {
  void closePage({
    required BuildContext context,
    required bool fromNativeOpen,
  }) {
    if (fromNativeOpen) {
      VgNativeMixFlutter().closeFlutterPage();
    } else {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      } else {
        VgNativeMixFlutter().closeFlutterPage();
      }
    }
  }
}

mixin VgWidgetMixinRefreshPage {
  void refresshPage({String? routerName, Map<Object?, Object?>? args}) {}
}
