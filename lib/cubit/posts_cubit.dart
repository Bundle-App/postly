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
  List<Post> localPosts = [];

  void retrieveAllPosts() async {
    emit(PostsProcessing());
    try {
      List<Map<String, dynamic>> onlinePosts =
          List<Map<String, dynamic>>.from(await postRepo.getOnlinePosts());
      allPosts = onlinePosts.map((e) => Post.fromMap(e)).toList();

      retrieveLocalPosts();
      emit(PostsRetrieved(allPosts));
    } on TimeoutException catch (e) {
      emit(PostsUnavailable(
          error: 'Check your Internet connection and try again'));
    } catch (e) {
      emit(PostsUnavailable(error: e.toString()));
    }
  }

  void retrieveLocalPosts() async {
    emit(PostsProcessing());
    try {
      List<String> repoLocalPosts = await postRepo.getSavedPosts();
      localPosts =
          repoLocalPosts.map((e) => Post.fromMap(jsonDecode(e))).toList();

      allPosts.addAll(localPosts);
      allPosts.sort((a, b) => b.id.compareTo(a.id));
      emit(PostsRetrieved(allPosts));
    } catch (e) {
      emit(PostsUnavailable(error: e.toString()));
    }
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
      retrieveLocalPosts();
    } catch (e) {
      response = e.toString();
    }

    return response;
  }
}
