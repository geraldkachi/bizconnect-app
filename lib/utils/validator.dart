import 'package:bizconnect/utils/string_utils.dart';

class Validator {
  // 
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  static String? validateConfirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Confirm Password is required';
    }
    if (confirmPassword != password) {
      return 'Passwords do not match';
    }
    return null;
  }
  // 
  // static String? validateEmail(String? s) {
  //   if (StringUtils.isEmpty(s)) {
  //     return "Email cannot be empty";
  //   } else if (!StringUtils.isValidEmail(s!)) {
  //     return "Email must be a valid email address";
  //   } else {
  //     return null;
  //   }
  // }

  static String? validate11Digits(String? s) {
    if (StringUtils.isEmpty(s)) {
      return "Field cannot be empty";
    } else if (s!.length < 11) {
      return "Field cannot be less than 11 digits";
    } else {
      return null;
    }
  }

  static String? validate10Digits(String? s) {
    if (StringUtils.isEmpty(s)) {
      return "Field cannot be empty";
    } else if (s!.length < 10) {
      return "Field cannot be less than 10 digits";
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(String? s) {
    if (StringUtils.isEmpty(s)) {
      return "Field cannot be empty";
    } else if (s!.length < 11) {
      return "Phone number cannot be less than 11 digits";
    } else {
      return null;
    }
  }

  static bool isValidate11Digits(String? s) {
    if (StringUtils.isEmpty(s)) {
      return false;
    } else if (s!.length < 11) {
      return false;
    } else {
      return true;
    }
  }

  static bool isValidate10Digits(String? s) {
    if (StringUtils.isEmpty(s)) {
      return false;
    } else if (s!.length < 10) {
      return false;
    } else {
      return true;
    }
  }

  static bool isValidEmail(String? s) {
    if (StringUtils.isEmpty(s)) {
      return false;
    } else if (!StringUtils.isValidEmail(s!)) {
      return false;
    } else {
      return true;
    }
  }

  static String? validateField(String? s, {String? errorMessage}) {
    if (StringUtils.isEmpty(s)) {
      return errorMessage ?? "Required";
    } else {
      return null;
    }
  }

  static bool isValidField(String? s) {
    if (StringUtils.isEmpty(s)) {
      return false;
    } else {
      return true;
    }
  }

  // static String? validatePassword(String? s) {
  //   if (StringUtils.isEmpty(s)) {
  //     return "Password cannot be empty";
  //   } else if (s!.length < 8) {
  //     return "Minimum of 8 characters";
  //   } else {
  //     return null;
  //   }
  // }

  static bool isValidPassword(String? s) {
    if (StringUtils.isEmpty(s)) {
      return false;
    } else if (s!.length < 8) {
      return false;
    } else {
      return true;
    }
  }

  static bool isCodeValid(String? s, [int length = 4]) {
    if (StringUtils.isEmpty(s)) {
      return false;
    } else if (s!.length < length) {
      return false;
    } else {
      return true;
    }
  }

  static String? validateNewPassword(String? s) {
    if (!StringUtils.hasLowerCase(s!)) {
      return "Password must contain uppercase";
    } else if (!StringUtils.hasUpperCase(s)) {
      return "Password must contain uppercase";
    } else if (!StringUtils.hasSymbol(s)) {
      return "Password must contain symbol";
    } else if (!StringUtils.hasNumber(s)) {
      return "Password must contain number";
    } else if (s.length < 8) {
      return "Password must be greater than 7 characters";
    } else if (StringUtils.isEmpty(s)) {
      return "Password cannot be empty";
    } else {
      return null;
    }
  }

  static bool isNewPasswordValid(String? s) {
    if (StringUtils.isEmpty(s)) {
      return false;
    } else if (!StringUtils.hasLowerCase(s!)) {
      return false;
    } else if (!StringUtils.hasUpperCase(s)) {
      return false;
    } else if (!StringUtils.hasSymbol(s)) {
      return false;
    } else if (!StringUtils.hasNumber(s)) {
      return false;
    } else if (s.length < 8) {
      return false;
    } else {
      return true;
    }
  }

  // static String? validateConfirmPassword(String? s, {String? password}) {
  //   if (StringUtils.isEmpty(s!.trim())) {
  //     return "Password cannot be empty";
  //   } else if (password!.trim() != s) {
  //     return "Passwords do not match";
  //   } else {
  //     return null;
  //   }
  // }

  static bool isConfirmPasswordValid(String? s, {String? password}) {
    if (StringUtils.isEmpty(s!.trim())) {
      return false;
    } else if (password!.trim() != s) {
      return false;
    } else {
      return true;
    }
  }
}
