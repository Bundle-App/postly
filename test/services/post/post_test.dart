import 'dart:convert';
import 'dart:io';

import 'package:Postly/commons/strings.dart';
import 'package:Postly/exceptions/exception.dart';
import 'package:Postly/models/http/request.dart';
import 'package:Postly/models/http/response.dart';
import 'package:Postly/models/post/post.dart';
import 'package:Postly/models/user/user.dart';
import 'package:Postly/services/auth/auth.dart';
import 'package:Postly/services/post/post.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mockito/mockito.dart';

import 'package:http/http.dart' as http;
import '../../commons/json_loader.dart';
import '../../commons/mocks.dart';

void main() {
  PostService postService;
  MockPostStorage storage;
  MockHttpService httpService;

  setUp(() {
    storage = MockPostStorage();
    httpService = MockHttpService();

    postService = PostServiceImpl(storage, httpService);
  });

  group('getUser', () {
    List<dynamic> _rawPosts;
    List<Post> _posts;
    final request = JsonRequest(
      path: 'posts',
    );

    setUp(() async {
      final postsString = await readJson('posts.json');
      _rawPosts = jsonDecode(postsString);
      _posts = _rawPosts.map((rawUser) => Post.fromJson(rawUser)).toList();
    });

    test('getPosts returns API posts successfully', () async {
      final responseBody = _rawPosts;

      final mockResponse = http.Response(jsonEncode(responseBody), 200);

      when(httpService.get(request))
          .thenAnswer((realInvocation) => Future.value(mockResponse));

      //success return
      final response = await postService.getPosts();
      expect(response, isInstanceOf<SuccessResponse<List<Post>>>());

      final retrievedPosts = response.extraData;

      final deepEq = const DeepCollectionEquality().equals;
      expect(deepEq(retrievedPosts, _posts), true);
    });

    test('getPosts returns with API failure', () async {
      final responseBody = {'message': 'Error from API'};
      final mockResponse = http.Response(
        jsonEncode(responseBody),
        400,
      );

      when(httpService.get(request))
          .thenAnswer((realInvocation) => Future.value(mockResponse));

      //failure return
      final response = await postService.getPosts();
      expect(response, isInstanceOf<FailureResponse<List<Post>>>());

      final message = response.message;
      expect(message, responseBody['message']);
    });

    test('getPosts returns with exceptions', () async {
      when(httpService.get(request)).thenThrow(SocketException('Socket'));
      expect(
        () async => await postService.getPosts(),
        throwsA(
          predicate((e) =>
              e is CustomException &&
              e.message == PostlyStrings.socketExceptionMessage),
        ),
      );

      when(httpService.get(request)).thenThrow(FormatException('Format'));
      expect(
        () async => await postService.getPosts(),
        throwsA(
          predicate((e) =>
              e is CustomException &&
              e.message == PostlyStrings.unexpectedExceptionMessage),
        ),
      );

      when(httpService.get(request)).thenThrow(Exception('General'));
      expect(
        () async => await postService.getPosts(),
        throwsA(
          predicate((e) =>
              e is CustomException &&
              e.message == PostlyStrings.unexpectedExceptionMessage),
        ),
      );
    });
  });

  final post = Post(id: 1, title: 'title', body: 'body');
  final posts = [post];
  group('createPost', () {
    test('verify call', () async {
      await postService.createPost(post);
      verify(storage.storeCreatedPost(post));
      verifyNoMoreInteractions(storage);
    });
  });

  group('getLocalPosts', () {
    test('returns posts if existent', () async {
      when(storage.getCreatedPosts())
          .thenAnswer((realInvocation) => Future.value(posts));

      final localPosts = await postService.getLocalPosts();
      verify(storage.getCreatedPosts());
      verifyNoMoreInteractions(storage);

      final deepEq = const DeepCollectionEquality().equals;
      expect(deepEq(localPosts, posts), true);
    });
  });
}
