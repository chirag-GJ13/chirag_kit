import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CKLocalStorage {
  CKLocalStorage._();

  // ─── Instances ─────────────────────────────────────────────
  static SharedPreferences? _prefs;

  static const _secure = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  // ─── Init ──────────────────────────────────────────────────
  /// main.dart mein call karo — runApp se pehle
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    debugPrint('✅ CKLocalStorage initialized');
  }

  static SharedPreferences get _instance {
    assert(_prefs != null, '⚠️ CKLocalStorage.init() pehle call karo!');
    return _prefs!;
  }

  // ════════════════════════════════════════════════════════════
  // 📦 NORMAL STORAGE — SharedPreferences (Non-sensitive)
  // ════════════════════════════════════════════════════════════

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

  // ════════════════════════════════════════════════════════════
  // 🔐 SECURE STORAGE — flutter_secure_storage (Sensitive)
  // ════════════════════════════════════════════════════════════

  // ─── String ────────────────────────────────────────────────
  static Future<void> setSecureString(String key, String value) =>
      _secure.write(key: key, value: value);

  static Future<String?> getSecureString(String key) => _secure.read(key: key);

  // ─── Remove ────────────────────────────────────────────────
  static Future<void> removeSecure(String key) => _secure.delete(key: key);

  // ─── Clear All ─────────────────────────────────────────────
  static Future<void> clearSecure() => _secure.deleteAll();

  // ─── Contains ──────────────────────────────────────────────
  static Future<bool> hasSecureKey(String key) => _secure.containsKey(key: key);

  // ════════════════════════════════════════════════════════════
  // 🧹 CLEAR BOTH — Logout pe use karo
  // ════════════════════════════════════════════════════════════
  static Future<void> clearAll() async {
    await clear();
    await clearSecure();
    debugPrint('✅ CKLocalStorage: All data cleared');
  }
}
