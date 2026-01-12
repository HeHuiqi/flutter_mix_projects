import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class VToast {
  static void show({String message = '操作成功'}) {
    showToast(message, textStyle: TextStyle(fontSize: 18, color: Colors.white));
  }
}
