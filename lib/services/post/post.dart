import 'dart:convert';
import 'dart:io';

import 'package:Postly/exceptions/exception.dart';
import 'package:Postly/models/http/request.dart';
import 'package:Postly/models/http/response.dart';
import 'package:Postly/models/post/post.dart';
import 'package:Postly/models/user/user.dart';
import 'package:Postly/services/http/http.dart';
import 'package:Postly/services/storage/post_storage.dart';
import 'package:Postly/services/storage/simple.dart';
import 'package:logging/logging.dart';
import 'package:Postly/extensions/response_extension.dart';

abstract class PostService {
  //get posts from remote
  Future<ApiResponse<List<Post>>> getPosts();

  //Create post locally
  Future<void> createPost(Post post);

  //get posts from local
  Future<List<Post>> getLocalPosts();
}

class PostServiceImpl implements PostService {
  final _log = Logger('PostServiceImpl');

  final _unexpectedExceptionMessage = 'An error occurred unexpectedly';
  final _socketExceptionMessage =
      'Operation failed. Check your network and retry';

  final PostStorageService storage;
  final HttpService httpService;

  PostServiceImpl(this.storage, this.httpService);

  @override
  Future<ApiResponse<List<Post>>> getPosts() async {
    try {
      final request = JsonRequest(
        path: 'posts',
      );

      final response = await httpService.post(request);
      final responseData = jsonDecode(response.body);

      if (!response.isSuccessful) {
        return FailureResponse.errorFromResponse(responseData);
      }

      final rawPostList = List<Map<String, dynamic>>.from(responseData);
      final postList = rawPostList.map((post) => Post.fromJson(post)).toList();

      final result = SuccessResponse<List<Post>>(extraData: postList);

      return result;
    } on SocketException catch (e, t) {
      _log.severe('getPosts', e);
      throw CustomException(_socketExceptionMessage);
    } on FormatException catch (e, t) {
      _log.severe('getPosts', e);
      throw CustomException(_unexpectedExceptionMessage);
    } catch (e, t) {
      _log.severe('getPosts', e);
      throw CustomException(_unexpectedExceptionMessage);
    }
  }

  @override
  Future<void> createPost(Post post) async {
    await storage.storeCreatedPost(post);
  }

  @override
  Future<List<Post>> getLocalPosts() async {
    final localPosts = await storage.getCreatedPosts();
    return localPosts;
  }
}
