import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

class CKBaseProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // ─── Safe Notify (tera purana logic — best approach) ──────
  @protected
  void safeNotify() {
    if ( !hasListeners) return;

    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      // Build phase chal raha hai — defer karo
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if ( hasListeners) notifyListeners();
      });
    } else {
      // Safe hai — seedha notify karo
      notifyListeners();
    }
  }

  // ─── Loading ───────────────────────────────────────────────
  @protected
  void setLoading(bool value) {
    if (_isLoading == value) return;
    _isLoading = value;
    safeNotify();
  }

}