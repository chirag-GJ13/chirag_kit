import 'package:chirag_kit/core/services/internet/ck_internet_service.dart';
import 'package:flutter/material.dart';

class CKAppWrapper extends StatelessWidget {
  final Widget child;
  final Color offlineBannerColor;
  final String offlineMessage;
  final double bannerHeight;

  const CKAppWrapper({
    super.key,
    required this.child,
    this.offlineBannerColor = Colors.red,
    this.offlineMessage = 'You are offline',
    this.bannerHeight = 36,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          // ─── Offline Banner ────────────────────────────
          StreamBuilder<bool>(
            stream: CKConnectivityService.instance.onConnectivityChanged,
            initialData: CKConnectivityService.instance.isConnected,
            builder: (context, snapshot) {
              final isConnected = snapshot.data ?? true;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: isConnected ? 0 : bannerHeight,
                child: CKOfflineBanner(
                  backgroundColor: offlineBannerColor,
                  message: offlineMessage,
                  height: bannerHeight,
                ),
              );
            },
          ),
          // ─── Main Content ──────────────────────────────
          Expanded(child: child),
        ],
      ),
    );
  }
}

class CKOfflineBanner extends StatelessWidget {
  final Color backgroundColor;
  final String message;
  final double height;

  const CKOfflineBanner({
    super.key,
    this.backgroundColor = Colors.red,
    this.message = 'You are offline',
    this.height = 36,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: height,
      width: double.infinity,
      color: backgroundColor,
      child: Center(
        child: Material(
          type: MaterialType.transparency,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off_rounded, color: Colors.white, size: 16),
              const SizedBox(width: 6),
              Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
