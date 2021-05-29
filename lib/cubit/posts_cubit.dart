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

  void retrieveAllPosts() async {
    emit(PostsProcessing());
    try {
      List<Map<String, dynamic>> repoOnlinePosts =
          List<Map<String, dynamic>>.from(await postRepo.getOnlinePosts());
      onlinePosts = repoOnlinePosts.map((e) => Post.fromMap(e)).toList();
      onlinePosts.sort((a, b) => b.id.compareTo(a.id));

      await retrieveLocalPosts();
      combineAndSortPosts();

    } on TimeoutException catch (e) {
      emit(PostsUnavailable(
          error: 'Check your Internet connection and try again'));
    } catch (e) {
      emit(PostsUnavailable(error: e.toString()));
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
    allPosts.clear();
    allPosts.addAll(onlinePosts);
    allPosts.addAll(localPosts);
    allPosts.sort((a, b) => b.id.compareTo(a.id));
    emit(PostsRetrieved(allPosts));
  }

  void switchToLocalPosts() {
    emit(PostsRetrieved(localPosts));
  }

  void switchToAllPosts() {
    emit(PostsRetrieved(allPosts));
  }

  Future<String> saveLocalPost(String title, String body) async {
    if (title.isEmpty || body.isEmpty) {
      return 'Please enter a title and body';
    }
    String response = '';
    try {
      Post post = Post(id: allPosts.length + 1, title: title, body: body);
      localPosts.add(post);
      await postRepo
          .savePosts(localPosts.map((e) => jsonEncode(e.toJson())).toList());

      await badgeCubit.addToPoints();

      await retrieveLocalPosts();
      combineAndSortPosts();
    } catch (e) {
      response = e.toString();
    }

    return response;
  }
}
