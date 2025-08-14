import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier {
  int _selectedNavigationIndex = 0;
  int get selectedNavigationIndex => _selectedNavigationIndex;

  void onNavigationTap(int index) {
    _selectedNavigationIndex = index;
    notifyListeners();
  }
}