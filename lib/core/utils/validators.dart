class CKValidators {
  CKValidators._();

  // ─── Regex — Ek jagah sab ──────────────────────────────────
  static final RegExp _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  static final RegExp _indianPhoneRegex = RegExp(r'^[6-9]\d{9}$');

  static final RegExp _alphabetsOnly = RegExp(r'^[a-zA-Z]+$');

  static final RegExp _strongPassword = RegExp(
    r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d@$!%*?&]{6,}$',
  );

  // ─── Required ──────────────────────────────────────────────
  static String? required(String? value, {String fieldName = 'Field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  // ─── Email ─────────────────────────────────────────────────
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    if (!_emailRegex.hasMatch(value.trim())) return 'Enter valid email';
    return null;
  }

  // ─── Mobile — Indian ───────────────────────────────────────
  static String? mobile(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Mobile number is required';
    }
    if (!_indianPhoneRegex.hasMatch(value.trim())) {
      return 'Enter valid 10 digit mobile number';
    }
    return null;
  }

  // ─── Password ──────────────────────────────────────────────
  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Minimum 6 characters required';
    return null;
  }

  static String? strongPassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (!_strongPassword.hasMatch(value)) {
      return 'Min 6 chars, one uppercase and one number required';
    }
    return null;
  }

  // ─── Length ────────────────────────────────────────────────
  static String? minLength(
    String? value,
    int min, {
    String fieldName = 'Field',
  }) {
    if (value == null || value.length < min) {
      return '$fieldName must be at least $min characters';
    }
    return null;
  }

  static String? maxLength(
    String? value,
    int max, {
    String fieldName = 'Field',
  }) {
    if (value != null && value.length > max) {
      return '$fieldName must be at most $max characters';
    }
    return null;
  }

  // ─── Alphabets Only ────────────────────────────────────────
  static String? alphabetsOnly(String? value, {String fieldName = 'Field'}) {
    if (value == null || value.trim().isEmpty) return '$fieldName is required';
    if (!_alphabetsOnly.hasMatch(value.trim())) {
      return '$fieldName must contain alphabets only';
    }
    return null;
  }

  // ─── Combine — Multiple validators ek saath ───────────────
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
