import 'package:shared_preferences/shared_preferences.dart';

import '../../setUp.dart';

class Storage {
  var prefs = locator<SharedPreferences>();
  setBool(String key, bool value) async {
    await prefs.setBool(key, value);
  }

  setString(String key, String value) async {
    await prefs.setString(key, value);
  }

  setInt(String key, int value) async {
    await prefs.setInt(key, value);
  }

  setDouble(String key, double value) async {
    await prefs.setDouble(key, value);
  }

  bool getBool(String key) {
    return prefs.getBool(key);
  }

  String getString(String key) {
    return prefs.getString(key);
  }

  double getDobule(String key) {
    return prefs.getDouble(key);
  }

  int getInt(String key) {
    return prefs.getInt(key);
  }
}
