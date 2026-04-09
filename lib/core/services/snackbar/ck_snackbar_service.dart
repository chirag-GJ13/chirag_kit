import 'package:flutter/material.dart';

class CKSnackBarService {
  CKSnackBarService._();

  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();

  // ─── Core Method ───────────────────────────────────────────
  static void show({
    required String message,
    Color backgroundColor = Colors.green,
    Duration duration = const Duration(seconds: 2),
    SnackBarAction? action,
    EdgeInsets margin = const EdgeInsets.all(30),
  }) {
    final state = scaffoldMessengerKey.currentState;

    if (state == null) {
      debugPrint('⚠️ CKSnackBarService: ScaffoldMessenger not ready → msg: $message');
      return;
    }

    debugPrint('📢 CKSnackBarService: $message');

    state
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: backgroundColor,
          duration: duration,
          behavior: SnackBarBehavior.floating,
          margin: margin,
          action: action,
        ),
      );
  }

  // ─── Shortcuts ─────────────────────────────────────────────
  static void success(String message) => show(
    message: message,
    backgroundColor: Colors.green,
  );

  static void error(String message) => show(
    message: message,
    backgroundColor: Colors.red,
  );

  static void warning(String message) => show(
    message: message,
    backgroundColor: Colors.orange,
  );

  static void info(String message) => show(
    message: message,
    backgroundColor: Colors.blue,
  );
}