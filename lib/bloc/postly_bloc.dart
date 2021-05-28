import 'dart:convert';
import 'dart:math';

import 'package:Postly/events/postly_events.dart';
import 'package:Postly/model/post.dart';
import 'package:Postly/model/user.dart';
import 'package:Postly/services/api_service.dart';
import 'package:Postly/states/postly_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostlyBloc extends Bloc<PostlyEvents, PostlyStates> {
  PostlyBloc(PostlyStates initialState) : super(initialState);

  ApiService _apiService = ApiService();

  @override
  Stream<PostlyStates> mapEventToState(PostlyEvents event) async* {
    if (event is GetPostlyDataEvent) {
      yield* _mapFetchPostsEventToState(event);
    } else if (event is FetchedDataEvent) {
      yield FetchedDataState(user: event.user, posts: event.posts);
    } else if (event is OnErrorEvent) {
      yield OnErrorState(errorMessage: event.errorMessage);
    } else if (event is NavigateToCreatePostEvent) {
      yield NavigateToCreatePostState();
    } else if (event is CreatePostEvent) {
      yield CreatePostState(newPost: event.newPost);
    }
  }

  Stream<PostlyStates> _mapFetchPostsEventToState(
      GetPostlyDataEvent event) async* {
    User user;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    /// Checking to see if any user data is stored locally
    bool checkIfPresent = sharedPreferences.containsKey("storedUser");

    try {
      /// If no user data is found on the device, a network call is made to get one
      if (!checkIfPresent) {
        final data = await _apiService.getUser();

        Random random = Random();

        int randomNumber = random.nextInt(data.length);

        /// A user is selected at random from the list of user data fetched from
        /// the network call
        user = User.fromJson(data[randomNumber]);

        /// Encoding the json data to String to be saved locally using SharePreferences
        String encodedUserData = jsonEncode(user);

        /// Saving the user data locally using SharePreferences
        sharedPreferences.setString("storedUser", encodedUserData);
      } else {
        String encodedUserData = sharedPreferences.get("storedUser");

        dynamic userDataDecode = jsonDecode(encodedUserData);

        user = User.fromJson(userDataDecode);
      }

      final postData = await _apiService.getPosts();

      List<Post> postList = [];

      for (var post in postData) {
        Post singlePost = Post.fromJson(post);
        postList.add(singlePost);
      }

      add(FetchedDataEvent(user: user, posts: postList));
    } catch (e) {
      add(OnErrorEvent(errorMessage: e.toString()));
    }
  }
}
