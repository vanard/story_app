import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier {
  int _selectedNavigationIndex = 0;
  int get selectedNavigationIndex => _selectedNavigationIndex;

  void onNavigationTap(int index, {bool notify = true}) {
    _selectedNavigationIndex = index;
    if (notify) {
      notifyListeners();
    }
  }

  void setNavigationIndex(int index) {
    if (_selectedNavigationIndex != index) {
      _selectedNavigationIndex = index;
      notifyListeners();
    }
  }
}