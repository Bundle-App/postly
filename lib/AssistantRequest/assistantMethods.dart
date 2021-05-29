import 'dart:math';

import 'package:Postly/AppData.dart/appData.dart';
import 'package:Postly/AssistantRequest/assistantRequest.dart';
import 'package:Postly/models/post.dart';
import 'package:Postly/models/user.dart';
import 'package:provider/provider.dart';
import 'package:Postly/services/storage.dart';

class AssistantMethods {
  //this fetches list of users from api and randomly selects which is to be used throughout the app
  static getUsersList(url, context) async {
    var storedUsername = await UserData.getUsername();
    var storedUserId = await UserData.getUserId();
    if (storedUsername != null && storedUserId != null) {
      print('first');
      print('username:$storedUsername');
      print('userId:$storedUserId');
      await Provider.of<PickedUser>(context, listen: false)
          .getPickedUser(storedUsername, storedUserId);
      return;
    }
    var response = await RequestAssistant.getRequest(url);
    if (response == 'Failed') {
      print('enter here');
      return;
    }
    Random random = new Random();
    int randomNumber = random.nextInt(response.length);
    var responseList =
        (response as List).map((user) => User.fromJson(user)).toList();
    User user = responseList[randomNumber];
    print(user.id);
    print(user.name);
    Provider.of<PickedUser>(context, listen: false)
        .getPickedUser(user.username, user.id);
  }

//this collects/fetches post from the api
  static getPost(url, context) async {
    var response = await RequestAssistant.getRequest(url);
    if (response == "Failed") {
      return;
    }
    var postList =
        (response as List).map((post) => Post.fromJson(post)).toList();
    Provider.of<PostList>(context, listen: false).getRecentPost(postList);
  }
}
