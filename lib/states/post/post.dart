import 'dart:async';

import 'package:Postly/exceptions/exception.dart';
import 'package:Postly/models/post/combined.dart';
import 'package:Postly/models/post/post.dart';
import 'package:Postly/services/post/post.dart';
import 'package:Postly/states/auth/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';

class PostState with ChangeNotifier {
  final PostService postService;

  PostState(
    this.postService,
  );

  late AuthState authState;

  final _log = Logger('PostState');

  Future<void> createPost(Post post) async {
    await postService.createPost(post);

    await authState.updatePoints();
  }

  @visibleForTesting
  CombinedPosts posts = CombinedPosts(
    createdByMe: [],
    fetchedRemotely: [],
  );

  Future<CombinedPosts> getPosts({
    bool isRefresh = false,
    bool isRefreshLocal = false,
  }) async {
    final completer = Completer<CombinedPosts>();

    if ((!posts.isEmpty) && !isRefresh && !isRefreshLocal) {
      completer.complete(posts);
      return completer.future;
    }

    final createdByMe = await postService.getLocalPosts();
    if (isRefreshLocal && !isRefresh) {
      //refresh only local posts after post creation
      final previousRemote = posts.fetchedRemotely;
      final combined = CombinedPosts(
        createdByMe: createdByMe,
        fetchedRemotely: previousRemote,
      );
      completer.complete(combined);
      return completer.future;
    }

    final fetchedRemotelyResponse = await postService.getPosts();
    if (!fetchedRemotelyResponse.isSuccessful) {
      throw CustomException(fetchedRemotelyResponse.message!);
    }

    final fetchedRemotely = fetchedRemotelyResponse.extraData;

    final combined = CombinedPosts(
      createdByMe: createdByMe,
      fetchedRemotely: fetchedRemotely!,
    );

    posts = combined;
    completer.complete(combined);
    return completer.future;
  }
}
