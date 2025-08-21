import 'package:flutter/material.dart';
import 'package:story_app/routes/page_configuration.dart';

class OverlayProvider extends ChangeNotifier {
  OverlayConfiguration? _activeOverlay;
  OverlayConfiguration? get activeOverlay => _activeOverlay;

  void showOverlay(OverlayType type, String taskId) {
    _activeOverlay = OverlayConfiguration(overlayType: type, taskId: taskId);
    notifyListeners();
  }

  void clearOverlay() {
    _activeOverlay = null;
    notifyListeners();
  }
}