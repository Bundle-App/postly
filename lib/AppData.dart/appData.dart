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
  getRecentPost(Iterable<Post> recentPost) {
    post = recentPost;
    notifyListeners();
  }
}
