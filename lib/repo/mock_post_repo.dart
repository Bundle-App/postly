import 'dart:async';
import 'dart:convert';

import 'package:Postly/model/post.dart';
import 'package:Postly/repo/post_repo.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockPostRepo implements PostRepo {
  List<Post> mockOnlinePosts = [
    Post(id: 1, title: 't1', body: 'b1'),
    Post(id: 2, title: 't2', body: 'b2'),
    Post(id: 3, title: 't3', body: 'b3')
  ];
  List<Post> mockLocalPosts = [
    Post(id: 4, title: 't4', body: 'b4'),
    Post(id: 5, title: 't5', body: 'b5'),
  ];

  List<Post> allPosts = [
    Post(id: 1, title: 't1', body: 'b1'),
    Post(id: 2, title: 't2', body: 'b2'),
    Post(id: 3, title: 't3', body: 'b3'),
    Post(id: 4, title: 't4', body: 'b4'),
    Post(id: 5, title: 't5', body: 'b5'),
  ];

  List<Post> allPostsWithSamplePost = [
    Post(id: 1, title: 't1', body: 'b1'),
    Post(id: 2, title: 't2', body: 'b2'),
    Post(id: 3, title: 't3', body: 'b3'),
    Post(id: 4, title: 't4', body: 'b4'),
    Post(id: 5, title: 't5', body: 'b5'),
    Post(id: 6, title: 't6', body: 'b6')
  ];

  List<Post> localPostsWithSamplePost = [
    Post(id: 4, title: 't4', body: 'b4'),
    Post(id: 5, title: 't5', body: 'b5'),
    Post(id: 6, title: 't6', body: 'b6')
  ];

  MockPostRepo();

  @override
  Future<List> getOnlinePosts() {
    // TODO: implement getOnlinePosts
    return Future.value(mockOnlinePosts.map((e) => e.toJson()).toList());
  }

  @override
  Future getSavedPosts() {
    // TODO: implement getSavedPosts
    return Future.value(
        mockLocalPosts.map((e) => jsonEncode(e.toJson())).toList());
  }

  @override
  Future<void> savePosts(List<String> postObjects) {
    return Future.value();
  }
}
