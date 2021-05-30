import 'dart:async';
import 'dart:convert';

import 'package:Postly/model/user.dart';
import 'package:Postly/repo/user_repo.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockUserRepo implements UserRepo{
  User mockUser = User(id: 0,name: 'Teejay',username: 'Tjmax',email: 'tj@bundle.come');
  MockUserRepo();

  @override
  Future checkUser() {
    return Future.value(jsonEncode(mockUser.toJson()));
  }

  @override
  Future<List> getNewUsers() {
    // TODO: implement getNewUsers
    throw UnimplementedError();
  }

  @override
  Future<void> saveUser(String userObject) {
    // TODO: implement saveUser
    throw UnimplementedError();
  }

}
