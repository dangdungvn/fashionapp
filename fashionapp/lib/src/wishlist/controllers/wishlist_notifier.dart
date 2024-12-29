import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/common/utils/environment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WishlistNotifier with ChangeNotifier {
  String? error;

  void setError(String e) {
    error = e;
    notifyListeners();
  }

  Future<void> addRemoveWishlist(int id, Function refetch) async {
    final accessToken = Storage().getString('accessToken');

    try {
      Uri url =
          Uri.parse('${Environment.appBaseUrl}/api/wishlist/toggle/?id=$id');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Token $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 201) {
        refetch();
      } else if (response.statusCode == 204) {
        refetch();
      }
    } catch (e) {
      error = e.toString();
    }
  }

  List _wishlist = [];

  List get wishlist => _wishlist;

  void setWishlist(List w) async {
    _wishlist.clear();
    _wishlist = w;
    notifyListeners();
  }
}
