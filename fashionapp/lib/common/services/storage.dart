import 'package:get_storage/get_storage.dart';

class Storage {
  void clear() {
    GetStorage().erase();
  }

  void setString(String key, String value) {
    GetStorage().write(key, value);
    
  }

  String? getString(String key) {
    return GetStorage().read(key);
  }

  void setBool(String key, bool value) {
    GetStorage().write(key, value);
  }

  bool? getBool(String key) {
    return GetStorage().read(key);
  }

   Future<void> removeKey(String key) {
    return GetStorage().remove(key);
  }
}
