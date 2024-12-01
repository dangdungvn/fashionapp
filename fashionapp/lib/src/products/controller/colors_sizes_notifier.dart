import 'package:flutter/material.dart';

class ColorsSizesNotifier extends ChangeNotifier {
  String _sizes = '';
  String get sizes => _sizes;
  void setSizes(String value) {
    if (_sizes == value) {
      _sizes = '';
    } else {
      _sizes = value;
    }
    notifyListeners();
  }

  String _colors = '';
  String get colors => _colors;
  void setColors(String valueColor) {
    if (_colors == valueColor) {
      _colors = '';
    } else {
      _colors = valueColor;
    }
    notifyListeners();
  }
}
