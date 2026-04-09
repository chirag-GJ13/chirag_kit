import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class CKConnectivityService extends ChangeNotifier {
  CKConnectivityService._internal() {
    _initialize();
  }

  static final CKConnectivityService instance =
      CKConnectivityService._internal();

  // ─── State ─────────────────────────────────────────────────
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  final StreamController<bool> _controller = StreamController.broadcast();

  bool _isConnected = true;

  bool get isConnected => _isConnected;

  // ─── Streams ───────────────────────────────────────────────
  Stream<bool> get onConnectivityChanged => _controller.stream;

  // ─── Init ──────────────────────────────────────────────────
  Future<void> _initialize() async {
    _isConnected = await _checkConnection();
    notifyListeners();

    _subscription = _connectivity.onConnectivityChanged.listen((results) async {
      final connected = await _checkConnection(results);
      if (_isConnected != connected) {
        _isConnected = connected;
        _controller.add(connected);
        debugPrint(
          '📡 CKConnectivityService: ${connected ? 'Online ✅' : 'Offline ❌'}',
        );
        notifyListeners();
      }
    });
  }

  // ─── One Time Check ────────────────────────────────────────
  Future<bool> hasInternetConnection() => _checkConnection();

  // ─── Core Check — Actual HTTP Request ──────────────────────
  Future<bool> _checkConnection([List<ConnectivityResult>? results]) async {
    final connectivityResult =
        results ?? await _connectivity.checkConnectivity();

    // Pehle quick check — connected hai bhi ya nahi
    if (connectivityResult.contains(ConnectivityResult.none)) {
      _controller.add(false);
      return false;
    }

    // Phir actual internet check — WiFi connected but internet nahi wala case
    try {
      final request = await HttpClient()
          .getUrl(Uri.parse('https://www.google.com'))
          .timeout(const Duration(seconds: 3));
      final response = await request.close();
      final connected = response.statusCode == 200;
      _controller.add(connected);
      return connected;
    } catch (_) {
      _controller.add(false);
      return false;
    }
  }

  // ─── Dispose ───────────────────────────────────────────────
  @override
  void dispose() {
    _subscription?.cancel();
    _controller.close();
    super.dispose();
  }
}
