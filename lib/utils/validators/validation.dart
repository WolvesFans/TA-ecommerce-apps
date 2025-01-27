//tanya semua ke chatgpt
// ignore_for_file: body_might_complete_normally_nullable

class CValidators {
  //empty text validation
  static String? validateEmptyText(String? fieldName, value) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
  }

  //email validation
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    //regex for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address';
    }

    return null;
  }

  //password validation
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    //minimum pass length
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    return null;
  }

  //admin password validation
  static String? validateAdminPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 3) {
      return 'Password must be at least 3 characters long';
    }
    return null;
  }

  //phone number validation
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required.';
    }

    // Regular expression for phone number validation (assuming a 10-digit US phone number format)
    final phoneRegExp = RegExp(r'\d{10,15}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number format (at least 10 digits required).';
    }

    return null;
  }
}
