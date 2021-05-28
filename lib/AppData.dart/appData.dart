import 'package:Postly/models/post.dart';
import 'package:Postly/services/storage.dart';
import 'package:flutter/foundation.dart';

class PickedUser with ChangeNotifier {
  String selectedUser;
  int selectedUserId;

  getPickedUser(String randomlyPickedUsername, int randomlyPickedUserId) async {
    selectedUser = randomlyPickedUsername;
    selectedUserId = randomlyPickedUserId;
    UserData.setUserName(selectedUser);
    UserData.setUserId(selectedUserId);
    notifyListeners();
  }
}

class PostList with ChangeNotifier {
  List<Post> post;
  getRecentPost(List<Post> recentPost) {
    post = recentPost;
    print(post.length);
    notifyListeners();
  }

  addNewPost(String title, String body) async {
    var storedUserId = await UserData.getUserId();
    post.insert(0, Post(storedUserId, post.length + 1, title, body));
    print('newpost:$post');
    print('userid:$storedUserId');
    print('postid:${post.first.id}');
    print(post.length);
    notifyListeners();
  }
}
