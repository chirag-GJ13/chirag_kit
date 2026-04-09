// ck_permission_service.dart — Lightweight version

import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

class CKPermissionService {
  CKPermissionService._();

  // ─── Core Method ───────────────────────────────────────────
  static Future<bool> _request(Permission permission) async {
    final status = await permission.request();
    debugPrint('📋 CKPermissionService: $permission → $status');
    return status.isGranted;
  }

  // ─── Camera ────────────────────────────────────────────────
  static Future<bool> requestCamera() => _request(Permission.camera);

  // ─── Gallery ───────────────────────────────────────────────
  static Future<bool> requestPhotos() => _request(Permission.photos);

  // ─── Check ─────────────────────────────────────────────────
  static Future<bool> isGranted(Permission permission) async {
    return (await permission.status).isGranted;
  }

  static Future<bool> isPermanentlyDenied(Permission permission) async {
    return (await permission.status).isPermanentlyDenied;
  }

  // ─── Settings Fallback ─────────────────────────────────────
  static Future<bool> requestWithSettingsFallback(
      Permission permission,
      ) async {
    final status = await permission.request();
    if (status.isPermanentlyDenied) {
      debugPrint('⚠️ CKPermissionService: permanently denied → opening settings');
      await openAppSettings();
      return false;
    }
    return status.isGranted;
  }

  // ─── Open Settings ─────────────────────────────────────────
  static Future<bool> openSettings() => openAppSettings();
}