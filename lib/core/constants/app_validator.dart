class AppValidator {
  static String? validateUserName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your username';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}
