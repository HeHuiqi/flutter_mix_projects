class VString {
  static String formatPrice({double? price}) {
    final currencySymbol = '€';
    if (price == null) {
      return '0.00$currencySymbol';
    }
    return '${price.toStringAsFixed(2)}$currencySymbol';
  }

  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  /// 验证手机号
  static bool isValidPhone(String phone) {
    final phoneRegex = RegExp(r'^1[0-9]{10}$');
    return phoneRegex.hasMatch(phone);
  }
}
