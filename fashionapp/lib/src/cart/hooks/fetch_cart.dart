import 'dart:convert';

import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/common/utils/environment.dart';
import 'package:fashionapp/src/cart/hooks/results/cart_results.dart';
import 'package:fashionapp/src/cart/models/cart_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchCart fetchCart() {
  final cart = useState<List<CartModel>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/cart/me/');
      String? accessToken = Storage().getString('accessToken');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Token $accessToken',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        cart.value = cartModelFromJson(utf8.decode(response.bodyBytes));
      } else {}
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    fetchData();
    return;
  }, const []);

  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  return FetchCart(
      cart: cart.value,
      isLoading: isLoading.value,
      error: error.value,
      refetch: refetch);
}
