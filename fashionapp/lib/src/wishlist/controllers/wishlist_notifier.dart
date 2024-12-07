import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/common/utils/environment.dart';
import 'package:fashionapp/src/categories/hooks/results/category_products_results.dart';
import 'package:fashionapp/src/products/models/products_model.dart';
import 'package:fashionapp/src/wishlist/hooks/fetch_wishlist.dart';
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
    print(w);
  }

  // void setToList(int v) async {
  //   String? accessToken = Storage().getString('accessToken');

  //   String? wishlist = Storage().getString('${accessToken}wishlist');

  //   if (wishlist == null) {
  //     List wishlist = [];
  //     wishlist.add(v);
  //     setWishlist(wishlist);

  //     Storage().setString('${accessToken}wishlist', jsonEncode(wishlist));
  //   } else {
  //     List w = jsonDecode(wishlist);

  //     if (w.contains(v)) {
  //       w.removeWhere((e) => e == v);
  //       setWishlist(w);

  //       Storage().setString('${accessToken}wishlist', jsonEncode(w));
  //     } else if (!w.contains(v)) {
  //       w.add(v);
  //       setWishlist(w);

  //       Storage().setString('${accessToken}wishlist', jsonEncode(w));
  //     }
  //   }
  // }

  void refreshWishlist() async {
    // Fetch the updated wishlist from the server
    FetchProduct fetchProduct = fetchWishlist();
    List<Products> updatedWishlist = fetchProduct.products;

    // Update the local wishlist state
    setWishlist(updatedWishlist.map((product) => product.id).toList());
  }
}
