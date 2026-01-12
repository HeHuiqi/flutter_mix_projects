import 'package:flutter/foundation.dart';

class VNetworkBaseConfig {
  static String baseUrl() {
    String url = "https://interface-api.desvips.com";

    if (kDebugMode) {
      // url = 'https://interface-test.voghion.com';
      url = "https://interface-api.desvips.com";
    }
    return url;
  }

  static Map<String, String> baseHeaders() {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Connection': 'keep-alive',
    };
    return headers;
  }
}
