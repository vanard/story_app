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
}