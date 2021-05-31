import 'dart:async';
import 'dart:math';

import 'package:Postly/configs/app_config.dart';
import 'package:Postly/di.dart';
import 'package:Postly/module/post/model/post/post.dart';
import 'package:Postly/module/post/model/user/user.dart';
import 'package:Postly/module/post/service/post_service.dart';
import 'package:Postly/utils/box_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'postly_event.dart';
part 'postly_state.dart';

class PostlyBloc extends Bloc<PostlyEvent, PostlyState> {
  @override
  // TODO: implement initialState
  PostlyState get initialState => PostInitial();




  @override
  Stream<PostlyState> mapEventToState(
    PostlyEvent event,
  ) async* {
    if (event is GetUsers) {
      yield* mapGetUsersFromServerEventToState();
    }
    if (event is GetPosts) {
      yield* mapGetPostsFromServerEventToState();
    }

    if (event is CreatePost) {
      yield* createPostEventToState(event);
    }
  }

  Stream<PostlyState> mapGetUsersFromServerEventToState() async* {
    yield FetchingUsers();
    final userBox =
    BoxHelper<User>().getBox(AppConfig.userBoxName); // Open User's box

    if (userBox.isNotEmpty) {
      // if the box is not empty register the user in the ioc for dependency injection
      ioc.registerSingleton<User>(userBox.get(0));
      yield FetchedUser();
      return;
    }

    try {
      // get users data from the api server
      var response = await ioc.get<PostService>().getUsers();
      if (response.isSuccessful) {
        var data = response.data as List;
        // Generate a random index starting from 0 - length of data - 1... which will helps to choose random user
        int randomIndex = Random().nextInt(data.length - 1);
        // use the randomly generated number to choose a user
        var user = User.fromJson(data[randomIndex]);
        // Save the selected user into local storage
        userBox.add(user); // add new data into the box
        // Register the selected User into ioc
        ioc.registerSingleton<User>(user);
        // Emit FetchedUser State
        yield FetchedUser();
      }
    } catch (e) {
      yield FetchedUsersWithError(message: "Error occured try again later");
    }
  }

  Stream<PostlyState> mapGetPostsFromServerEventToState() async* {
    yield FetchingPosts();
    final postBox =
    BoxHelper<Post>().getBox(AppConfig.postBoxName);
    try {
      // Fetch post from the api server
      var response = await ioc.get<PostService>().getPost();
      if (response.isSuccessful) {
        var data = response.data as List;
        // get the current user from ioc
        var currentUser = ioc.get<User>();
        // filter and get list of post for the current user using the userId as the key criteria
        List<Post> posts = data
            .map((e) => Post.fromJson(e))
            .toList()
            .where((element) => element.userId == currentUser.id)
            .toList();
        // Get user post from local storage
        var localPosts = postBox.values.toList();
        // append the localPost retrieved from the local storage with the posts from the live server
        posts = [...posts, ...localPosts];
        // // Add posts to the valueNotifier variable
        // postList.value = posts;
        // Emit FetchedPosts State
        yield FetchedPosts(posts: posts);
      }
    } catch (e) {
      yield FetchedUsersWithError(message: "Error occured try again later");
    }
  }

  Stream<PostlyState> createPostEventToState(CreatePost event) async* {
    yield CreatingPost();
    var currentUser = ioc.get<User>();
    final postBox =
    BoxHelper<Post>().getBox(AppConfig.postBoxName);
    final userBox =
    BoxHelper<User>().getBox(AppConfig.userBoxName); // Open User's box

    try {
           event.post.userId = currentUser.id;
           postBox.add(event.post); // save the post into post table
           // Add 2 points to the user for creating a post
           currentUser.points = currentUser.points + 2;
           // Update the current user to reflect the user's new points
           userBox.putAt(0, currentUser);
           postList.value = [...postList.value,event.post];
      yield CreatedPost();
    } catch (e) {
      yield CreatePostWithError(message: "Error occured try again later");
    }
  }
}
