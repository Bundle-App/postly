import 'package:Postly/cubit/badge_cubit.dart';
import 'package:Postly/cubit/posts_cubit.dart';
import 'package:Postly/cubit/user_cubit.dart';
import 'package:Postly/model/post.dart';
import 'package:Postly/repo/mock_badge_repo.dart';
import 'package:Postly/repo/mock_post_repo.dart';
import 'package:Postly/repo/mock_user_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  //badge test
  group('BadgeCubit test', () {
    BadgeCubit badgeCubit;
    MockBadgeRepo mockBadgeRepo;

    setUp(() {
      EquatableConfig.stringify = true;
      mockBadgeRepo = MockBadgeRepo();
      badgeCubit = BadgeCubit(mockBadgeRepo);
    });

    blocTest<BadgeCubit, BadgeState>(
      'Initializes the badge cubit, adds 6 points and resets the points',
      build: () => badgeCubit,
      act: (cubit) async {
        await cubit.initBadge();
        await cubit.addToPoints(6);
        await cubit.resetPoints();
      },
      expect: () => [BadgeBeginner(), BadgeIntermediate(), BadgeBeginner()],
    );

    tearDown(() {
      badgeCubit?.close();
    });
  });

  //user test
  group('UserCubit test', () {
    UserCubit userCubit;
    MockUserRepo mockUserRepo;

    setUp(() {
      EquatableConfig.stringify = true;
      mockUserRepo = MockUserRepo();
      userCubit = UserCubit(mockUserRepo);
    });

    blocTest<UserCubit, UserState>(
      'Checks for a saved user and returns the user object',
      build: () => userCubit,
      act: (cubit) async {
        await cubit.retrieveUser();
      },
      expect: () => [UserProcessing(), UserActive(mockUserRepo.mockUser)],
    );

    tearDown(() {
      userCubit?.close();
    });
  });

  //posts test
  group('PostsCubit test', () {
    PostsCubit postCubit;
    BadgeCubit badgeCubit;
    MockPostRepo mockPostRepo;
    List<Post> allPosts=[];
    List<Post> allPostsWithSampleMockPost=[];
    List<Post> localPostsWithSampleMockPost=[];

    setUp(() {
      EquatableConfig.stringify = true;
      mockPostRepo = MockPostRepo();
      badgeCubit = BadgeCubit(MockBadgeRepo());
      postCubit = PostsCubit(mockPostRepo, badgeCubit);

      allPosts = mockPostRepo.allPosts;
      allPosts.sort((a, b) => b.id.compareTo(a.id));

      allPostsWithSampleMockPost = mockPostRepo.allPostsWithSamplePost;
      allPostsWithSampleMockPost.sort((a, b) => b.id.compareTo(a.id));

      localPostsWithSampleMockPost = mockPostRepo.localPostsWithSamplePost;
      localPostsWithSampleMockPost.sort((a, b) => b.id.compareTo(a.id));
    });

    blocTest<PostsCubit, PostsState>(
      'Retrieves local and online posts, saves a local post, switches to local post view and switches back to all post view',
      build: () => postCubit,
      act: (cubit) async {
        await cubit.retrieveAllPosts();
        await cubit.saveLocalPost('t6', 'b6');
        cubit.switchToLocalPosts();
        cubit.switchToAllPosts();
      },
      expect: () => [
        PostsProcessing(),
        PostsRetrieved(allPosts),
        PostsRetrieved(allPostsWithSampleMockPost),
        PostsRetrieved(mockPostRepo.localPostsWithSamplePost),
        PostsRetrieved(allPostsWithSampleMockPost)
      ],
    );


    tearDown(() {
      postCubit?.close();
    });
  });
}
