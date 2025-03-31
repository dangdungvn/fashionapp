// ignore_for_file: use_build_context_synchronously, prefer_final_fields

import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/common/utils/environment.dart';
import 'package:fashionapp/src/cart/models/cart_model.dart';
import 'package:fashionapp/src/entrypoint/controllers/bottom_tab_notifier.dart';
import 'package:fashionapp/src/products/controller/colors_sizes_notifier.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

class CartNotifier with ChangeNotifier {
  Function? refetchCount;
  void setRefetchCount(Function r) {
    refetchCount = r;
  }

  int _qty = 0;
  int get qty => _qty;
  void increment() {
    _qty++;
    notifyListeners();
  }

  void decrement() {
    if (_qty > 1) {
      _qty--;
      notifyListeners();
    }
  }

  int? _selectedCart;
  int? get selectedCart => _selectedCart;
  void setSelectedCounter(int id, int q) {
    _selectedCart = id;
    _qty = q;
    notifyListeners();
  }

  void clearSelected() {
    _selectedCart = null;
    _selectedCartItems.clear();
    _selectedCartItemsId.clear();
    _qty = 0;
    _totalPrice = 0;
    notifyListeners();
  }

  Future<void> deleteCart(int id, void Function() refetch) async {
    String? accessToken = Storage().getString('accessToken');
    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/cart/delete/?id=$id');
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );
      if (response.statusCode == 204) {
        refetch();
        refetchCount!();
        clearSelected();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> updateCart(int id, void Function() refetch) async {
    String? accessToken = Storage().getString('accessToken');
    try {
      Uri url = Uri.parse(
          '${Environment.appBaseUrl}/api/cart/update/?id=$id&count=$qty');
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );
      if (response.statusCode == 200) {
        refetch();
        clearSelected();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> addToCart(String data, BuildContext ctx) async {
    String? accessToken = Storage().getString('accessToken');
    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/cart/add/');
      final response = await http.post(
        url,
        body: data,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );
      if (response.statusCode == 201) {
        refetchCount!();
        ctx.read<ColorsSizesNotifier>().setSizes("");
        ctx.read<ColorsSizesNotifier>().setColors("");
        ctx.read<TabIndexNotifier>().setIndex(2);
        ctx.go('/home');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  List<int> _selectedCartItemsId = [];
  List<int> get selectedCartItemsId => _selectedCartItemsId;

  List<CartModel> _selectedCartItems = [];
  List<CartModel> get selectedCartItems => _selectedCartItems;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  void _calculateTotalPrice() {
    _totalPrice = _selectedCartItems.fold(
        0, (sum, item) => sum + (item.product.price * item.quantity));
    notifyListeners();
  }

  void selectOrDeselect(int id, CartModel cartItem) {
    if (_selectedCartItemsId.contains(id)) {
      _selectedCartItemsId.remove(id);
      _selectedCartItems.removeWhere((i) => i.id == id);
    } else {
      _selectedCartItemsId.add(id);
      _selectedCartItems.add(cartItem);
    }
    _calculateTotalPrice();
    notifyListeners();
  }

  void selectAll(List<CartModel> carts) {
    for (var cart in carts) {
      if (!_selectedCartItemsId.contains(cart.id)) {
        _selectedCartItemsId.add(cart.id);
        _selectedCartItems.add(cart);
      }
    }
    _calculateTotalPrice();
    notifyListeners();
  }

  String _paymentUrl = '';
  String get paymentUrl => _paymentUrl;
  void setPaymentUrl(String url) {
    _paymentUrl = url;
    notifyListeners();
  }

  String _success = '';
  String get success => _success;
  void setSuccessUrl(String url) {
    _success = url;
    notifyListeners();
  }

  void createCheckout(String data) async {
    try {
      // https://e0e5-146-70-95-181.ngrok-free.app/stripe/create-checkout-session
      Uri url = Uri.parse(
          "${Environment.paymentBaseUrl}/stripe/create-checkout-session");

      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: data);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        setPaymentUrl(responseData['url']);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
