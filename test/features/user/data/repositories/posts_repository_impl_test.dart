import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:postly/core/error/failure.dart';
import 'package:postly/core/network/network_info.dart';
import 'package:postly/features/user/data/datasources/posts_local_data_source.dart';
import 'package:postly/features/user/data/datasources/posts_remote_data_source.dart';
import 'package:postly/features/user/data/models/posts_model.dart';
import 'package:postly/features/user/data/repositories/posts_repository_impl.dart';
import 'package:postly/features/user/domain/entities/posts.dart';

class MockPostsRemoteDataSource extends Mock implements PostsRemoteDataSource {}

class MockPostsLocalDataSource extends Mock implements PostsLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MockPostsRemoteDataSource mockRemoteDataSource;
  late MockPostsLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late PostsRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockPostsRemoteDataSource();
    mockLocalDataSource = MockPostsLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = PostsRepositoryImpl(
        localDataSource: mockLocalDataSource,
        remoteDataSource: mockRemoteDataSource,
        networkInfo: mockNetworkInfo);
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getPosts', () {
    final tPostsModel = <PostsModel>[
      PostsModel(
        id: 1,
        title: 'title test',
        body: 'body test',
      ),
      PostsModel(
        id: 2,
        title: 'title test',
        body: 'body test',
      )
    ];
    final List<Posts> tPosts = tPostsModel;

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        await repository.getPosts();
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getRemotePosts())
              .thenAnswer((_) async => tPostsModel);
          // act
          final result = await repository.getPosts();
          // assert
          verify(mockRemoteDataSource.getRemotePosts());

          expect(result, equals(Right(tPosts)));
        },
      );

      test(
        'should cache the data locally when the call is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getRemotePosts())
              .thenAnswer((_) async => tPostsModel);
          // act
          await repository.getPosts();
          // assert
          verify(mockRemoteDataSource.getRemotePosts());
          verify(mockLocalDataSource.cacheLastPost(tPostsModel));
        },
      );

      test(
        'should return server failure when the call is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.getRemotePosts())
              .thenThrow(ServerException());
          // act
          final result = await repository.getPosts();
          // assert
          verify(mockRemoteDataSource.getRemotePosts());
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return last cached data when the cached data is present',
        () async {
          // arrange
          when(mockLocalDataSource.getCachedPosts())
              .thenAnswer((_) async => tPostsModel);
          // act
          final result = await repository.getPosts();
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getCachedPosts());
          expect(result, equals(Right(tPosts)));
        },
      );

      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          // arrange
          when(mockLocalDataSource.getCachedPosts())
              .thenThrow(CacheException());
          // act
          final result = await repository.getPosts();
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getCachedPosts());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });
}
