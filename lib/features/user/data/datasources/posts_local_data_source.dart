import 'dart:convert';

import 'package:postly/core/error/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/strings.dart';
import '../models/posts_model.dart';

abstract class PostsLocalDataSource {
  ///fetch the last posts, throw exception if no cache data is present
  Future<List<PostsModel>> getCachedPosts();

  ///method to cache the last data that was fetched
  Future<void> cacheLastPost(List<PostsModel> postsModel);
}

class PostsLocalDataSourceImpl implements PostsLocalDataSource {
  PostsLocalDataSourceImpl(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  @override
  Future<List<PostsModel>> getCachedPosts() {
    final jsonString = sharedPreferences.getString(Strings.cachedPostsString);
    if (jsonString != null) {
      final parsed = json.decode(jsonString);
      return Future.value(
          parsed.map<PostsModel>((json) => PostsModel.fromJson(json)).toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheLastPost(List<PostsModel> postsModel) {
    return sharedPreferences.setString(
      Strings.cachedPostsString,
      json.encode(List<dynamic>.from(postsModel.map((x) => x.toJson()))),
    );
  }
}
