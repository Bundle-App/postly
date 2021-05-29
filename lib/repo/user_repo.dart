import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepo {
  static const String newUsersUrl =
      'https://jsonplaceholder.typicode.com/users';

  UserRepo();

  Future<dynamic> checkUser() async {
    var localDb = await SharedPreferences.getInstance();
    var savedUser = localDb.getString('user');
    return savedUser;
  }

  Future<List<dynamic>> getNewUsers() async {
    try {
      var response = await get(Uri.parse(newUsersUrl)).timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      return Future.error(e);
    }
    return [];
  }

  Future<void> saveUser(String userObject) async {
    var localDb = await SharedPreferences.getInstance();
    await localDb.setString('user', userObject);
  }
}
