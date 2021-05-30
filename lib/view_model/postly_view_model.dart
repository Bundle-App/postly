import 'dart:async';
import 'dart:math';

import 'package:Postly/data/repository/data_repository/post_services.dart';
import 'package:Postly/data/repository/data_repository/user_services.dart';
import 'package:Postly/data/repository/database/hive_repository.dart';
import 'package:Postly/models/posts/post.dart';
import 'package:Postly/models/user/user.dart';
import 'package:Postly/utils/constants.dart';
import 'package:Postly/widget/badge.dart';
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
  //Retrieved user from local db is set in provider view model
  setUser(User user) => _user = user;
  set user(User value) {
    _user = value;
    notifyListeners();
  }

  // List<Post> get viewPosts => posts;
  setPosts(List<Post> value) {
    posts = value;
    notifyListeners();
  }

  //Points of the user
  int get viewPoints => _viewPoints;
  setViewPoints(int points) => _viewPoints = points;

  //This function gets user from network and picks a random user which is saved locally
  Future<List<User>> getUser() async {
    users = await _userServices.getUsers();
    int index = randomNum.nextInt(users.length);
    //picks random user in list
    User deviceUser = users[index];
    //puts user in hive
    _hiveRepository.add<User>(name: kUserBox, key: kUser, item: deviceUser);

    _user = deviceUser;
    notifyListeners();
    return users;
  }

  //get post from network
  Future<List<Post>> getPost() async {
    posts = await _postServices.getPosts();
    await _hiveRepository.add<List<Post>>(
        name: kPostBox, key: kPosts, item: posts);
    notifyListeners();
    return posts;
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
    } else {
      _isLoading = true;

      var _post = Post(title: postTitle, body: postText);
      //Timer class is used to delay function and simulate loading state
      Timer(Duration(seconds: 2), () {
        User user = _hiveRepository.get<User>(name: kUserBox, key: kUser);
        posts.add(_post);
        _viewPoints = user.points += 2;
        _hiveRepository.add<User>(name: kUserBox, key: kUser, item: user);
        _isLoading = false;
        _postText = "";
        Navigator.pushNamedAndRemoveUntil(
            context, POST_SCREEN_ROUTE, (route) => false);
      });

      notifyListeners();
    }
  }

  //method is called to check points of user anytime the come unto the app
  void checkPoints(context) async {
    Navigator.pushReplacementNamed(context, POST_SCREEN_ROUTE);
    //if point is greater than 16, dialog box is shown immediately user opens the app
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

  // This method returns a widget depending on user points
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
