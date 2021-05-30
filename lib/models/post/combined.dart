import 'package:Postly/models/post/post.dart';
import 'package:flutter/cupertino.dart';

class CombinedPosts {
  final List<Post> createdByMe;
  final List<Post> fetchedRemotely;

  CombinedPosts({
    required this.createdByMe,
    required this.fetchedRemotely,
  });

  bool get isEmpty {
    return createdByMe.isEmpty && fetchedRemotely.isEmpty;
  }
}
