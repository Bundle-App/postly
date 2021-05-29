import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostRepo {
  static const String newUsersUrl =
      'https://jsonplaceholder.typicode.com/posts';

  PostRepo();

  Future<dynamic> getSavedPosts() async {
    var localDb = await SharedPreferences.getInstance();
    List<String> savedPosts = localDb.getStringList('posts') ?? [];
    return savedPosts;
  }

  Future<List<dynamic>> getOnlinePosts() async {
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

  Future<void> savePosts(List<String> postObjects) async {
    var localDb = await SharedPreferences.getInstance();
     await localDb.setStringList('posts', postObjects);
    await Future.delayed(Duration(milliseconds: 1500));
  }
}
