import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BadgeRepo {
  static const String newUsersUrl =
      'https://jsonplaceholder.typicode.com/users';

  BadgeRepo();

  Future<int> getPoints() async {
    var localDb = await SharedPreferences.getInstance();
    var savedPoints =localDb.getInt('points') ?? 0;
    return savedPoints;
  }

  Future<void> savePoints(int points) async {
    var localDb = await SharedPreferences.getInstance();
     await localDb.setInt('points', points);
  }

}
