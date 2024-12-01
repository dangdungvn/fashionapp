import 'package:fashionapp/src/products/models/products_model.dart';
import 'package:flutter/material.dart';

class ProductNotifier with ChangeNotifier {
  Products? product;

  void setProduct(Products p) {
    product = p;
    notifyListeners();
  }

  bool _description = false;
  bool get description => _description;
  void setDescription() {
    _description = !_description;
    notifyListeners();
  }

  void resetDescription() {
    _description = false;
  }
}
