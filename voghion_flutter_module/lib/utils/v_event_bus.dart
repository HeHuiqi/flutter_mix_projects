class VEventBus {
  static final VEventBus _singleton = VEventBus._internal();
  factory VEventBus() {
    return _singleton;
  }
  VEventBus._internal();
  final Map<String, List<Function>> _eventMap = {};
  void on(String eventName, Function callback) {
    if (!_eventMap.containsKey(eventName)) {
      _eventMap[eventName] = [];
    }
    _eventMap[eventName]?.add(callback);
  }

  void off(String eventName, Function callback) {
    if (_eventMap.containsKey(eventName)) {
      _eventMap[eventName]?.remove(callback);
    }
  }

  void emit(String eventName, [dynamic data]) {
    if (_eventMap.containsKey(eventName)) {
      List<Function> callbacks = _eventMap[eventName]!;
      for (var callback in callbacks) {
        callback(data);
      }
    }
  }

  static String vLoginLogoutEvent = 'vLoginLogoutEvent';
  static String vAddToCartEvent = 'vAddToCartEvent';
  static String vAddRefreshCartEvent = 'vAddRefreshCartEvent';
}
