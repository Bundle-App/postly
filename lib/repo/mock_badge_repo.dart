import 'dart:async';
import 'dart:convert';

import 'package:Postly/cubit/badge_cubit.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'badge_repo.dart';

class MockBadgeRepo implements BadgeRepo{
  @override
  Future<int> getPoints() {
    return Future.value(0);
  }

  @override
  Future<void> savePoints(int points) {
    return Future.value();
  }


}
