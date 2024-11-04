import 'package:flutter/material.dart';

class OnboardingNotifier with ChangeNotifier {
  int _selectedPage = 0;
  int get selectedPage => _selectedPage;

  set setSelectedPage(int val) {
    _selectedPage = val;
    // print(val);
    notifyListeners();
  }
}
