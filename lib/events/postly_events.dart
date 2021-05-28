import 'package:Postly/model/post.dart';
import 'package:Postly/model/user.dart';
import 'package:flutter/cupertino.dart';

abstract class PostlyEvents {}

/// Event that triggers fetching of user data (if none is present locally) and
/// fetching post from the network
class GetPostlyDataEvent extends PostlyEvents {}

/// Event that signals the user data and posts data has been gotten
class FetchedDataEvent extends PostlyEvents {
  User user;
  List<Post> posts;

  FetchedDataEvent({@required this.user, @required this.posts});
}

/// Event that indicates an error has occurred doing an operation. It includes
/// the error message designation
class OnErrorEvent extends PostlyEvents {
  String errorMessage;

  OnErrorEvent({@required this.errorMessage});
}

/// Event for when the button to navigate to the "Create Post" page is clicked
class NavigateToCreatePostEvent extends PostlyEvents {}

/// Event that handles publishing a newly created post
class CreatePostEvent extends PostlyEvents {
  Post newPost;

  CreatePostEvent({@required this.newPost});
}
