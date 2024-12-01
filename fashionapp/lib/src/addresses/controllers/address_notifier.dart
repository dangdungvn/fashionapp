// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:fashionapp/common/models/api_error_model.dart';
import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/common/utils/environment.dart';
import 'package:fashionapp/common/widgets/error_modal.dart';
import 'package:fashionapp/src/addresses/models/addresses_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class AddressNotifier with ChangeNotifier {
  Function refetchA = () {};

  void setRefetch(Function r) {
    refetchA = r;
    // notifyListeners();
  }

  AddressModel? address;
  void setAddress(AddressModel value) {
    address = value;
    notifyListeners();
  }

  void clearAddress() {
    address = null;
    notifyListeners();
  }

  List<String> addressTypes = ["Home", "School", "Office"];
  String _addressType = "";
  void setAddressType(String value) {
    _addressType = value;
    notifyListeners();
  }

  String get addressType => _addressType;

  void clearAddressType() {
    _addressType = "";
    notifyListeners();
  }

  bool _defaultToggle = false;
  void setDefaultToggle(bool value) {
    _defaultToggle = value;
    notifyListeners();
  }

  bool get defaultToggle => _defaultToggle;

  void setAsDefault(int id, Function refetch, BuildContext context) async {
    String? accessToken = Storage().getString("accessToken");
    try {
      Uri url =
          Uri.parse("${Environment.appBaseUrl}/api/address/default/?id=$id");
      final response = await http.patch(
        url,
        headers: {
          "Authorization": "Token $accessToken",
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        refetch();
      } else if (response.statusCode == 404 || response.statusCode == 400) {
        var data = apiErrorFromJson(utf8.decode(response.bodyBytes));
        showErrorPopup(context, data.message, "Error changing address", true);
        debugPrint(data.message);
      } else {
        var data = apiErrorFromJson(utf8.decode(response.bodyBytes));
        showErrorPopup(context, data.message, "Error changing address", true);
        debugPrint(data.message);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void deleteAddress(int id, Function refetch, BuildContext context) async {
    String? accessToken = Storage().getString("accessToken");
    try {
      Uri url =
          Uri.parse("${Environment.appBaseUrl}/api/address/delete/?id=$id");
      final response = await http.delete(
        url,
        headers: {
          "Authorization": "Token $accessToken",
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        refetch();
      } else if (response.statusCode == 404 || response.statusCode == 400) {
        var data = apiErrorFromJson(utf8.decode(response.bodyBytes));
        showErrorPopup(context, data.message, "Error deleting address", true);
        debugPrint(data.message);
      } else {
        var data = apiErrorFromJson(utf8.decode(response.bodyBytes));
        showErrorPopup(context, data.message, "Error deleting address", true);
        debugPrint(data.message);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void addAddress(String data, BuildContext context) async {
    String? accessToken = Storage().getString("accessToken");
    try {
      Uri url = Uri.parse("${Environment.appBaseUrl}/api/address/add/");
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Token $accessToken",
          "Content-Type": "application/json",
        },
        body: data,
      );
      if (response.statusCode == 201) {
        refetchA();
        context.pop();
      } else {
        var data = apiErrorFromJson(utf8.decode(response.bodyBytes));
        showErrorPopup(context, data.message, "Error adding address", true);
        debugPrint(data.message);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
