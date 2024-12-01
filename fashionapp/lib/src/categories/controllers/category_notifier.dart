import 'package:flutter/material.dart';

class CategoryNotifier with ChangeNotifier {
  String category = '';
  int _id = 0;

  void setCategory(String value, int id) {
    category = value;
    _id = id;
    notifyListeners();
  }

  int get id => _id;
}
