import 'package:flutter/material.dart';

class MainViewModel extends ChangeNotifier {
  int _currentPageIndex = 0;

  MainViewModel();

  int get currentPageIndex => _currentPageIndex;

  void setPageIndex(int index) {
    if (_currentPageIndex != index) {
      _currentPageIndex = index;
      notifyListeners();
    }
  }
}
