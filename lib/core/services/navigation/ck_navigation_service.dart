import 'package:flutter/material.dart';

class CKNavigationService {
  CKNavigationService._();

  // ─── Navigator Key ─────────────────────────────────────────
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  // ─── Getter ────────────────────────────────────────────────
  static NavigatorState get _navigator => navigatorKey.currentState!;

  static BuildContext get context => navigatorKey.currentContext!;

  // ─── Helper for Animations ─────────────────────────────────
  /// This creates a smooth "Slide from Right" animation
  static Route<T> _createAnimatedRoute<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // We define the starting point (Right) and end point (Center)
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutQuart; // Smooth movement

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }

  // ─── Push ──────────────────────────────────────────────────
  /// Animated push — slides in from the right
  static Future<T?> push<T>({required Widget page}) {
    return _navigator.push<T>(_createAnimatedRoute(page));
  }

  /// Named route push (Animations usually handled in onGenerateRoute for named)
  static Future<T?> pushNamed<T>(String routeName, {Object? arguments}) {
    return _navigator.pushNamed<T>(routeName, arguments: arguments);
  }

  // ─── Push Replacement ──────────────────────────────────────
  /// Replace current screen with animation
  static Future<T?> pushReplacement<T>({required Widget page}) {
    return _navigator.pushReplacement<T, dynamic>(_createAnimatedRoute(page));
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
  /// Clear stack and push new screen with animation
  static Future<T?> pushAndRemoveUntil<T>({required Widget page}) {
    return _navigator.pushAndRemoveUntil<T>(
      _createAnimatedRoute(page),
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
  static void pop<T>({T? result}) {
    if (_navigator.canPop()) {
      _navigator.pop<T>(result);
    }
  }

  static void popUntil(String routeName) {
    _navigator.popUntil(ModalRoute.withName(routeName));
  }

  static Future<T?> popAndPush<T>({required Widget page}) {
    _navigator.pop();
    return push(page: page);
  }

  // ─── Checks ────────────────────────────────────────────────
  static bool canPop() => _navigator.canPop();
}
