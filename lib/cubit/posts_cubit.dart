import 'dart:async';
import 'dart:convert';

import 'package:Postly/cubit/badge_cubit.dart';
import 'package:Postly/model/post.dart';
import 'package:Postly/repo/post_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostRepo postRepo;
  BadgeCubit badgeCubit;

  PostsCubit(this.postRepo, this.badgeCubit) : super(PostsUnavailable());

  List<Post> allPosts = [];
  List<Post> onlinePosts = [];
  List<Post> localPosts = [];
  String onlinePostsError = '';

  /// retrieve local and online posts, sorts them and emits result
  Future<void> retrieveAllPosts() async {
    onlinePostsError = '';
    emit(PostsProcessing());
    try {
      //retrieve online posts
      List<Map<String, dynamic>> repoOnlinePosts =
          List<Map<String, dynamic>>.from(await postRepo.getOnlinePosts());
      onlinePosts = repoOnlinePosts.map((e) => Post.fromMap(e)).toList();
      onlinePosts.sort((a, b) => b.id.compareTo(a.id));

      // retrieve local posts
      await retrieveLocalPosts();

      // adds all posts together and sorts them
      combineAndSortPosts();
    } on TimeoutException catch (e) {
      onlinePostsError = 'Check your Internet connection and try again';
      emit(PostsUnavailable(error: onlinePostsError));
    } catch (e) {
      onlinePostsError = e.toString();
      emit(PostsUnavailable(error: onlinePostsError));
    }
  }

  Future<void> retrieveLocalPosts() async {
    emit(PostsProcessing());
    try {
      List<String> repoLocalPosts = await postRepo.getSavedPosts();
      localPosts =
          repoLocalPosts.map((e) => Post.fromMap(jsonDecode(e))).toList();
      localPosts.sort((a, b) => b.id.compareTo(a.id));
    } catch (e) {
      emit(PostsUnavailable(error: e.toString()));
    }
  }

  void combineAndSortPosts() {
    allPosts.addAll(onlinePosts);
    allPosts.addAll(localPosts);
    allPosts.sort((a, b) => b.id.compareTo(a.id));
    emit(PostsRetrieved(allPosts));
  }

  void switchToLocalPosts() async {
    if (localPosts.isEmpty) {
      await retrieveLocalPosts();
    }
    emit(PostsRetrieved(localPosts));
  }

  void switchToAllPosts() {
    if (onlinePostsError.isNotEmpty) {
      emit(PostsUnavailable(error: onlinePostsError));
      return;
    }
    emit(PostsRetrieved(allPosts));
  }

  /// save to local when post is created, adds to points and re-fetches posts
  Future<String> saveLocalPost(String title, String body) async {
    if (title.isEmpty || body.isEmpty) {
      return 'Please enter a title and body';
    }
    String response = '';
    try {
      Post post = Post(id: allPosts.length + 1, title: title, body: body);
      localPosts = [post, ...localPosts];
      await postRepo
          .savePosts(localPosts.map((e) => jsonEncode(e.toJson())).toList());

      await badgeCubit.addToPoints(2);

      List<Post> newAllPost = [post, ...allPosts];
      emit(PostsRetrieved(newAllPost));
      allPosts = newAllPost;
    } catch (e) {
      response = e.toString();
    }

    return response;
  }
}
