import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CKStorageService {
  CKStorageService._();

  static SharedPreferences? _prefs;

  // ─── Init ──────────────────────────────────────────────────
  /// main.dart mein call karo — runApp se pehle
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    debugPrint('✅ CKStorageService initialized');
  }

  static SharedPreferences get _instance {
    assert(_prefs != null, '⚠️ CKStorageService.init() pehle call karo!');
    return _prefs!;
  }

  // ─── String ────────────────────────────────────────────────
  static Future<bool> setString(String key, String value) =>
      _instance.setString(key, value);

  static String? getString(String key) => _instance.getString(key);

  // ─── Int ───────────────────────────────────────────────────
  static Future<bool> setInt(String key, int value) =>
      _instance.setInt(key, value);

  static int? getInt(String key) => _instance.getInt(key);

  // ─── Bool ──────────────────────────────────────────────────
  static Future<bool> setBool(String key, bool value) =>
      _instance.setBool(key, value);

  static bool? getBool(String key) => _instance.getBool(key);

  // ─── Double ────────────────────────────────────────────────
  static Future<bool> setDouble(String key, double value) =>
      _instance.setDouble(key, value);

  static double? getDouble(String key) => _instance.getDouble(key);

  // ─── Remove ────────────────────────────────────────────────
  static Future<bool> remove(String key) => _instance.remove(key);

  // ─── Clear All ─────────────────────────────────────────────
  static Future<bool> clear() => _instance.clear();

  // ─── Contains ──────────────────────────────────────────────
  static bool hasKey(String key) => _instance.containsKey(key);
}
