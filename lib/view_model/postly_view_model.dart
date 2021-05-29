import 'dart:async';
import 'dart:math';

import 'package:Postly/data/repository/data_repository/post_services.dart';
import 'package:Postly/data/repository/data_repository/user_services.dart';
import 'package:Postly/data/repository/database/hive_repository.dart';
import 'package:Postly/models/post.dart';
import 'package:Postly/models/user/user.dart';
import 'package:Postly/utils/constants.dart';
import 'package:Postly/views/post_screen.dart';
import 'package:Postly/widget/pop_up_dialog.dart';
import 'package:Postly/widget/postly_flush_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../locator.dart';

class PostlyViewModel extends ChangeNotifier {
  var _userServices = locator<UserServices>();
  var _postServices = locator<PostServices>();
  var _hiveRepository = locator<HiveRepository>();
  List<User> users = [];
  List<Post> posts = [];
  Random randomNum = Random();
  User _user;
  int _viewPoints = 0;
  String _postText = "";
  String _postTitle = "";
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  //create post text
  String get postText => _postText;
  set setPost(String value) {
    _postText = value;
    notifyListeners();
  }

  //post title
  String get postTitle => _postTitle;
  set setTitle(String value) {
    _postTitle = value;
    notifyListeners();
  }

  //get user
  User get user => _user;
  //Retrived user from local db is set in provider
  setUser(User user) => _user = user;
  set user(User value) {
    _user = value;
    notifyListeners();
  }

  //Points of the user
  int get viewPoints => _viewPoints;
  setViewPoints(int points) => _viewPoints = points;

  //This function gets user from network and picks a random user which is saved locally
  void getUser() async {
    users = await _userServices.getUsers();
    int index = randomNum.nextInt(users.length) + 1;
    print(users);
    User deviceUser = users[index];
    _hiveRepository.add<User>(name: kUserBox, key: kUser, item: deviceUser);
    _user = deviceUser;
    print('deviceUser ${deviceUser.email}');
    notifyListeners();
  }

  //get post from network
  void getPost() async {
    posts = await _postServices.getPosts();
    print(posts);
    notifyListeners();
  }

  //Creates post and gives user two points
  void createPost(context) async {
    if (postText.isEmpty ||
        postText == null ||
        postTitle.isEmpty ||
        postTitle == null) {
      PostlyFlushBar.showFloating(context,
          message: "All fields must be filled",
          title: "Error",
          backgroundColor: Colors.red);
      // notifyListeners();
    } else {
      _isLoading = true;
      Timer(Duration(seconds: 2), () {
        User user = _hiveRepository.get<User>(name: kUserBox, key: kUser);
        _viewPoints = user.points += 2;
        _hiveRepository.add<User>(name: kUserBox, key: kUser, item: user);
        _isLoading = false;
        _postText = "";
        Navigator.pushNamedAndRemoveUntil(context, '/post', (route) => false);
      });

      notifyListeners();
    }
  }

  void checkPoints(context) async {
    Navigator.pushReplacementNamed(context, '/post');
    if (_viewPoints > 16) {
      await showDialog(
        context: context,
        builder: (BuildContext context) => PopupDialog(),
      );
      User user = _hiveRepository.get<User>(name: kUserBox, key: kUser);
      _viewPoints = user.points = 0;
      _hiveRepository.add<User>(name: kUserBox, key: kUser, item: user);
      notifyListeners();
    }
  }

  Widget badge() {
    Widget userBadge;
    if (_viewPoints < 6) {
      userBadge = Badge(level: 'Beginner', image: 'beginner');
    } else if (_viewPoints >= 6 && viewPoints < 10) {
      userBadge = Badge(level: 'Intermediate', image: 'intermediate');
    } else if (_viewPoints >= 10 && viewPoints <= 16) {
      userBadge = Badge(level: 'Professional', image: 'professional');
    } else if (_viewPoints > 16) {
      userBadge = Badge(level: 'Legend', image: 'legend');
    }
    return userBadge;
  }
}
