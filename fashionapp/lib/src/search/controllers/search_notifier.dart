import 'dart:convert';

import 'package:fashionapp/common/utils/environment.dart';
import 'package:fashionapp/src/products/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchNotifier with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  List<Products> _results = [];

  List<Products> get results => _results;

  void setResults(List<Products> v) {
    _results = v;
    notifyListeners();
  }

  void clearResults() {
    _results = [];
  }

  String _searchKey = '';

  String get searchKey => _searchKey;

  void setSearchKey(String v) {
    _searchKey = v;
    notifyListeners();
  }

  String? _error;

  String get error => _error ?? "";

  void setError(String v) {
    _error = v;
    notifyListeners();
  }

  void searchFunction(String searchKey) async {
    setLoading(true);
    setSearchKey(searchKey);
    Uri url = Uri.parse(
        '${Environment.appBaseUrl}/api/products/search/?q=$searchKey');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = productsFromJson(utf8.decode(response.bodyBytes));
        setResults(data);
        setLoading(false);
      }
    } catch (e) {
      setError(e.toString());
      setLoading(false);
      // e.toString();
    }
  }
}
