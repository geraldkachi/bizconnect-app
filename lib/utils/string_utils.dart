import 'package:intl/intl.dart';

class StringUtils {
  static String currencyConverter(int amount, [int decimalDigits = 0]) {
    String formattedAmount =
        NumberFormat.currency(symbol: '', decimalDigits: decimalDigits)
            .format(amount);
    return formattedAmount;
  }

  static bool isEmpty(String? s) {
    return s == null || s.isEmpty;
  }

  static bool isNotEmpty(String? s) {
    return s != null && s.isNotEmpty;
  }

  static bool hasUpperCase(String password) {
    return RegExp('(?:[A-Z])').hasMatch(password);
  }

  static bool hasLowerCase(String password) {
    return RegExp('(?:[a-z])').hasMatch(password);
  }

  static bool hasSymbol(String password) {
    return RegExp(r"[!@#$%^&*(),\|+=;.?':{}|<>]").hasMatch(password);
  }

  static bool hasNumber(String password) {
    return RegExp('(?=.*?[0-9])').hasMatch(password);
  }

  static bool isValidSterlingEmail(String email) {
    return RegExp(
      "^[a-zA-Z0-9+._%-+]{1,256}@sterling.ng\$",
    ).hasMatch(email);
  }

  static bool isValidEmail(String email) {
    return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email);
  }

  static String formatCreditCardNumber(String cardNumber) {
    // Add spaces to the credit card number based on the specified format
    String formattedNumber = '';
    for (int i = 0; i < cardNumber.length; i++) {
      if (i == 4 || i == 8 || i == 12) {
        formattedNumber += ' - ';
      }
      formattedNumber += cardNumber[i];
    }
    return formattedNumber;
  }

  static String hideStrings(String number, int prefixCount, int suffixCount) {
    int length = number.length;
    if (length <= prefixCount + suffixCount) return number;

    final prefix = number.substring(0, prefixCount);
    final suffix = number.substring(length - suffixCount);

    int asterisksCount = length - (prefixCount + suffixCount);
    return "$prefix${"*" * asterisksCount}$suffix";
  }
}
