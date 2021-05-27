import 'package:Postly/model/post.dart';
import 'package:Postly/model/user.dart';
import 'package:flutter/cupertino.dart';

abstract class PostlyStates {}

class LoadingState extends PostlyStates {}

class FetchedDataState extends PostlyStates {
  User user;
  List<Post> posts;

  FetchedDataState({@required this.user, @required this.posts});
}

class OnErrorState extends PostlyStates {
  String errorMessage;

  OnErrorState({@required this.errorMessage});
}

class NavigateToCreatePostState extends PostlyStates {}

class CreatePostState extends PostlyStates {
  Post newPost;

  CreatePostState({@required this.newPost});
}

class UserIsAProfessionalState extends PostlyStates {}
