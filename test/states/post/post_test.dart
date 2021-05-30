import 'package:Postly/exceptions/exception.dart';
import 'package:Postly/models/http/response.dart';
import 'package:Postly/models/post/combined.dart';
import 'package:Postly/models/post/post.dart';
import 'package:Postly/models/user/user.dart';
import 'package:Postly/states/auth/auth.dart';
import 'package:Postly/states/post/post.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mockito/mockito.dart';

import '../../commons/mocks.dart';

void main() {
  late PostState postState;
  late MockPostService postService;
  late MockAuthState authState;

  setUp(() {
    postService = MockPostService();
    authState = MockAuthState();
    postState = PostState(postService);
    postState.authState = authState;
  });

  final firstPost = Post(id: 1, title: 'title', body: 'body');
  final secondPost = Post(id: 2, title: 'title2', body: 'body2');
  final thirdPost = Post(id: 3, title: 'title3', body: 'body3');

  test('createPost-state', () async {
    when(postService.createPost(firstPost))
        .thenAnswer((realInvocation) => Future.value());
    when(authState.updatePoints())
        .thenAnswer((realInvocation) => Future.value());

    await postState.createPost(firstPost);
    verifyInOrder([
      postService.createPost(firstPost),
      authState.updatePoints(),
    ]);
  });

  group('getPosts', () {
    final combined = CombinedPosts(
      createdByMe: [firstPost],
      fetchedRemotely: [secondPost],
    );

    test('normal return', () async {
      when(postService.getLocalPosts()).thenAnswer(
        (realInvocation) => Future.value([firstPost]),
      );
      when(postService.getPosts()).thenAnswer(
        (realInvocation) =>
            Future.value(SuccessResponse<List<Post>>(extraData: [secondPost])),
      );

      expect(
          postState.posts, predicate((e) => e is CombinedPosts && e.isEmpty));
      await postState.getPosts();

      final deepEq = const DeepCollectionEquality().equals;
      expect(deepEq(postState.posts.createdByMe, combined.createdByMe), true);
      expect(deepEq(postState.posts.fetchedRemotely, combined.fetchedRemotely),
          true);

      verifyInOrder([
        postService.getLocalPosts(),
        postService.getPosts(),
      ]);
    });

    test('returns existing copy on default operation', () async {
      postState.posts = combined;

      final posts = await postState.getPosts();
      expect(posts, combined);

      verifyZeroInteractions(postService);
    });

    test('returns updated local, same remote if isRefreshLocal is true',
        () async {
      postState.posts = combined;

      when(postService.getLocalPosts()).thenAnswer(
        (realInvocation) => Future.value([
          firstPost,
          thirdPost,
        ]),
      );

      final posts = await postState.getPosts(isRefreshLocal: true);
      final deepEq = const DeepCollectionEquality().equals;
      expect(deepEq(posts.createdByMe, combined.createdByMe), false);
      expect(deepEq(posts.fetchedRemotely, combined.fetchedRemotely), true);

      verify(postService.getLocalPosts());
      verifyNoMoreInteractions(postService);
    });

    test('successfully returns updated local and remote if isRefresh is true',
        () async {
      postState.posts = combined;

      when(postService.getLocalPosts()).thenAnswer(
        (realInvocation) => Future.value([
          firstPost,
          thirdPost,
        ]),
      );
      when(postService.getPosts()).thenAnswer(
        (realInvocation) =>
            Future.value(SuccessResponse<List<Post>>(extraData: [
          secondPost,
          thirdPost,
        ])),
      );

      final posts = await postState.getPosts(isRefresh: true);
      final deepEq = const DeepCollectionEquality().equals;
      expect(deepEq(posts.createdByMe, combined.createdByMe), false);
      expect(deepEq(posts.fetchedRemotely, combined.fetchedRemotely), false);
      expect(postState.posts, posts);

      verifyInOrder([
        postService.getLocalPosts(),
        postService.getPosts(),
      ]);
    });

    test(
        'fails from API response in returning updated local and remote if isRefresh is true',
        () async {
      postState.posts = combined;

      when(postService.getLocalPosts()).thenAnswer(
        (realInvocation) => Future.value([
          firstPost,
          thirdPost,
        ]),
      );
      when(postService.getPosts()).thenAnswer(
        (realInvocation) =>
            Future.value(FailureResponse<List<Post>>(message: 'failed')),
      );

      expect(
        () async => await postState.getPosts(isRefresh: true),
        throwsA(
          predicate((e) => e is CustomException && e.message == 'failed'),
        ),
      );

      verify(postService.getLocalPosts());
      verifyNoMoreInteractions(postService);
    });
  });
}
