class Validators {
  /// Required field
  static String? required(String? value, {String fieldName = 'Field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// Email validation
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    final emailRegex =
    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter valid email';
    }

    return null;
  }

  static String? validateAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Address is required';
    }
    if (value.trim().length < 10) {
      return 'Address must be at least 10 characters';
    }
    return null;
  }


  /// Mobile number (10 digit)
  static String? mobile(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Mobile number is required';
    }

    final cleaned = value.trim();

    if (!RegExp(r'^[0-9]{10}$').hasMatch(cleaned)) {
      return 'Enter valid 10 digit number';
    }

    return null;
  }

  /// Minimum length
  static String? minLength(String? value, int min) {
    if (value == null || value.length < min) {
      return 'Minimum $min characters required';
    }
    return null;
  }

  /// Maximum length
  static String? maxLength(String? value, int max) {
    if (value != null && value.length > max) {
      return 'Maximum $max characters allowed';
    }
    return null;
  }

  /// Password (basic)
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Minimum 6 characters required';
    }

    return null;
  }

  /// Combine multiple validators
  static String? combine(
      String? value,
      List<String? Function(String?)> validators,
      ) {
    for (final validator in validators) {
      final result = validator(value);
      if (result != null) return result;
    }
    return null;
  }
}