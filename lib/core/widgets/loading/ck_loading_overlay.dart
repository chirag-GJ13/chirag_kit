import 'package:chirag_kit/core/services/navigation/ck_navigation_service.dart';
import 'package:flutter/material.dart';

class CKLoadingOverlay {
  CKLoadingOverlay._();

  static OverlayEntry? _overlayEntry;
  static bool _isVisible = false;

  // ─── Show ──────────────────────────────────────────────────
  static void show({
    Color barrierColor = Colors.black38,
    Color indicatorColor = Colors.white,
    double indicatorSize = 50,
  }) {
    // Already visible hai toh dobara mat dikhao
    if (_isVisible) return;

    final context = CKNavigationService.navigatorKey.currentContext;

    if (context == null) {
      debugPrint('⚠️ CKLoadingOverlay: context not available');
      return;
    }

    _isVisible = true;

    _overlayEntry = OverlayEntry(
      builder: (_) => PopScope(
        // ─── Back button disable ───────────────────────────
        canPop: false,
        child: GestureDetector(
          // ─── Tap disable ──────────────────────────────────
          onTap: () {},
          child: ColoredBox(
            color: barrierColor,
            child: Center(
              child: SizedBox(
                width: indicatorSize,
                height: indicatorSize,
                child: CircularProgressIndicator(
                  color: indicatorColor,
                  strokeWidth: 3,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  // ─── Hide ──────────────────────────────────────────────────
  static void hide() {
    if (!_isVisible) return;
    _overlayEntry?.remove();
    _overlayEntry = null;
    _isVisible = false;
  }

  // ─── Is Visible ────────────────────────────────────────────
  static bool get isVisible => _isVisible;
}
