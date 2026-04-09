import 'dart:io';

import 'package:chirag_kit/core/services/permission/ck_permission_service.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CKImagePickerService {
  CKImagePickerService._();

  static final _picker = ImagePicker();

  // ─── Camera ────────────────────────────────────────────────
  static Future<File?> fromCamera() async {
    final granted = await CKPermissionService.requestWithSettingsFallback(
      Permission.camera,
    );
    if (!granted) return null;

    final picked = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    return _toFile(picked);
  }

  // ─── Gallery ───────────────────────────────────────────────
  static Future<File?> fromGallery() async {
    final granted = await CKPermissionService.requestWithSettingsFallback(
      Permission.photos,
    );
    if (!granted) return null;

    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    return _toFile(picked);
  }

  // ─── Helper ────────────────────────────────────────────────
  static File? _toFile(XFile? xfile) {
    if (xfile == null) return null;
    debugPrint('📸 CKImagePickerService: picked → ${xfile.path}');
    return File(xfile.path);
  }
}
