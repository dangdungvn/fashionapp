import 'package:flutter/material.dart';

class PasswordNotifier extends ChangeNotifier {
  bool _password = true;

  bool get password => _password;

  void setPassword() {
    _password = !_password;
    notifyListeners();
  }
}
