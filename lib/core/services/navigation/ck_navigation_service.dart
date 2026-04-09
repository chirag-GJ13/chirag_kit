import 'package:flutter/material.dart';

class CKNavigationService {
  CKNavigationService._();

  // ─── Navigator Key ─────────────────────────────────────────
  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  // ─── Getter ────────────────────────────────────────────────
  static NavigatorState get _navigator => navigatorKey.currentState!;

  static BuildContext get context => navigatorKey.currentContext!;

  // ─── Push ──────────────────────────────────────────────────
  /// Normal push — back button se wapas aa sakte ho
  static Future<T?> push<T>({required Widget page}) {
    return _navigator.push<T>(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  /// Named route push
  static Future<T?> pushNamed<T>(
      String routeName, {
        Object? arguments,
      }) {
    return _navigator.pushNamed<T>(routeName, arguments: arguments);
  }

  // ─── Push Replacement ──────────────────────────────────────
  /// Current screen replace karo — back nahi ja sakte
  static Future<T?> pushReplacement<T>({required Widget page}) {
    return _navigator.pushReplacement<T, dynamic>(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  static Future<T?> pushReplacementNamed<T>(
      String routeName, {
        Object? arguments,
      }) {
    return _navigator.pushReplacementNamed<T, dynamic>(
      routeName,
      arguments: arguments,
    );
  }

  // ─── Push And Remove Until ─────────────────────────────────
  /// Saari screens hata ke naya screen — Login logout flow
  static Future<T?> pushAndRemoveUntil<T>({required Widget page}) {
    return _navigator.pushAndRemoveUntil<T>(
      MaterialPageRoute(builder: (_) => page),
          (route) => false,
    );
  }

  static Future<T?> pushAndRemoveUntilNamed<T>(
      String routeName, {
        Object? arguments,
      }) {
    return _navigator.pushNamedAndRemoveUntil<T>(
      routeName,
          (route) => false,
      arguments: arguments,
    );
  }

  // ─── Pop ───────────────────────────────────────────────────
  /// Normal back
  static void pop<T>({T? result}) {
    if (_navigator.canPop()) {
      _navigator.pop<T>(result);
    }
  }

  /// Specific route tak wapas jao
  static void popUntil(String routeName) {
    _navigator.popUntil(ModalRoute.withName(routeName));
  }

  /// Pop kar ke naya screen push karo
  static Future<T?> popAndPush<T>({required Widget page}) {
    _navigator.pop();
    return push(page: page);
  }

  // ─── Checks ────────────────────────────────────────────────
  static bool canPop() => _navigator.canPop();
}