import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/utils/strings.dart';
import '../models/user_model.dart';

abstract class UserLocalDataSource {
  Future<UserModel> getCachedUser();

  Future<void> cacheUser(UserModel userModel);

  bool hasCache();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  UserLocalDataSourceImpl(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  @override
  Future<UserModel> getCachedUser() {
    final jsonString = sharedPreferences.getString(Strings.cachedUserString);
    if (jsonString != null) {
      return Future.value(UserModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUser(UserModel userModel) {
    return sharedPreferences.setString(
      Strings.cachedUserString,
      json.encode(userModel.toJson()),
    );
  }

  @override
  bool hasCache() {
    var cache = sharedPreferences.getString(Strings.cachedUserString);
    if (cache == null) {
      return false;
    }
    return true;
  }
}
