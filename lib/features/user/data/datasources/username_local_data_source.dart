import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/utils/strings.dart';
import '../models/username_model.dart';

abstract class UsernameLocalDataSource {
  Future<UsernameModel> getCachedUsername();

  Future<void> cacheUsername(UsernameModel usernameModel);

  bool hasCache();
}

class UsernameLocalDataSourceImpl implements UsernameLocalDataSource {
  UsernameLocalDataSourceImpl(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  @override
  Future<UsernameModel> getCachedUsername() {
    final jsonString =
        sharedPreferences.getString(Strings.cachedUsernameString);
    if (jsonString != null) {
      return Future.value(UsernameModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUsername(UsernameModel usernameModel) {
    return sharedPreferences.setString(
      Strings.cachedUsernameString,
      json.encode(usernameModel.toJson()),
    );
  }

  @override
  bool hasCache() {
    var cache = sharedPreferences.getString(Strings.cachedUsernameString);
    if (cache == null) {
      return false;
    }
    return true;
  }
}
