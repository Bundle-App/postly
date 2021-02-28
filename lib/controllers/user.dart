import 'dart:convert';
import 'dart:io';
import "dart:math";

import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:postly/enums/app_state.dart';
import 'package:postly/models/models.dart';
import 'package:postly/models/user.dart';
import 'package:get/get.dart';
import 'package:postly/services/posts/post.dart';
import 'package:postly/services/storage/index.dart';
import 'package:postly/services/users/user.dart';
import 'package:postly/setUp.dart';

class UserController extends GetxController {
  User user;
  List<Post> posts;
  AppState appState = AppState.loading;
  UserService _userService = locator<UserService>();
  PostService _postService = locator<PostService>();
  Storage _storage = locator<Storage>();
  int _userPoints;

  getData() async {
    try {
      _userPoints = _storage.getInt("points") ?? 0;
      final _random = new Random();
      dynamic _usersResponse = await _userService.getUsers();
      dynamic _postResponse = await _postService.getPost();

      List _postDecoded = json.decode(_postResponse.body);
      posts = _postDecoded.map((e) => Post.fromJson(e)).toList();

      List _usersDecoded = json.decode(_usersResponse.body);
      List<User> usersObjects =
          _usersDecoded.map((e) => User.fromJson(e)).toList();

      user = usersObjects[_random.nextInt(usersObjects.length)];
      user.points = _userPoints;
      appState = AppState.none;
      checkDialog();
    } on SocketException {
      appState = AppState.noInternet;
    } catch (e) {
      appState = AppState.error;
    }
    update();
  }

  addNewPost(Map data) async {
    user.points += 2;
    await _storage.setInt("points", user.points);
    posts = [Post.fromJson(data), ...posts];
    update();
  }

  checkDialog() {
    _userPoints = _storage.getInt("points") ?? 0;
    if (_userPoints > 16) {
      Get.dialog(
        AlertDialog(
          content: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Text("You are a postly legend"),
          ),
        ),
      ).then(
        (value) async {
          user.points = 0;
          await _storage.setInt("points", 0);
          update();
        },
      );
    }
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
