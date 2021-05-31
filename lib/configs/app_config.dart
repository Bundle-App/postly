import 'package:Postly/module/post/model/post/post.dart';
import 'package:flutter/material.dart';

class AppConfig {
  static String baseUrl = "https://jsonplaceholder.typicode.com/";
  static String getUserUrl = "users";
  static String getPostUrl = "posts";
  static String userBoxName =
      "users"; // The table name where user will be saved
  static String postBoxName =
      "posts"; // The table name where user will be saved
}

ValueNotifier<List<Post>> postList = ValueNotifier([]);

getTextSize(BuildContext context, {double size = 16}) {
  return MediaQuery.of(context).size.height * (size / 1000);
}
