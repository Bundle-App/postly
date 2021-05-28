import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  static Future<String> getUsername() async {
    final pref = await SharedPreferences.getInstance();
    final key = 'username';
    final valueStored = pref.getString(key) ?? null;
    return valueStored;
  }

  static Future<int> getUserId() async {
    final pref = await SharedPreferences.getInstance();
    final key = 'userId';
    final valueStored = pref.getInt(key) ?? null;
    return valueStored;
  }

  static Future<int> getPoint() async {
    final pref = await SharedPreferences.getInstance();
    final key = 'userPoint';
    final valueStored = pref.getInt(key) ?? 0;
    return valueStored;
  }

  static setUserName(String username) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('username', username);
  }

  static setUserId(int userId) async {
    final pref = await SharedPreferences.getInstance();
    pref.setInt('userId', userId);
  }

  static setPoints(int userPoint) async {
    final pref = await SharedPreferences.getInstance();
    pref.setInt('userPoint', userPoint);
  }
}
