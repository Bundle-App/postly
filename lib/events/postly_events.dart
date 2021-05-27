import 'package:Postly/model/post.dart';
import 'package:Postly/model/user.dart';
import 'package:flutter/cupertino.dart';

abstract class PostlyEvents {}

class LoadingEvent extends PostlyEvents {}

class GetPostlyDataEvent extends PostlyEvents {}

class FetchedDataEvent extends PostlyEvents {
  User user;
  List<Post> posts;

  FetchedDataEvent({@required this.user, @required this.posts});
}

class OnErrorEvent extends PostlyEvents {
  String errorMessage;

  OnErrorEvent({@required this.errorMessage});
}

class NavigateToCreatePostEvent extends PostlyEvents {}

class CreatePostEvent extends PostlyEvents {
  Post newPost;

  CreatePostEvent({@required this.newPost});
}
