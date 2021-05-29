import 'package:postly/core/usecases/usecase.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:postly/features/user/domain/entities/posts.dart';
import 'package:postly/features/user/domain/repositories/posts_repository.dart';
import 'package:postly/features/user/domain/usecases/get_posts.dart';

class MockPostsRepository extends Mock implements PostsRepository {}

void main() {
  MockPostsRepository repository;
  GetPosts usecase;
  const tPosts = [
    Posts(
      id: 1,
      title: 'title test',
      body: 'body test',
    ),
    Posts(
      id: 2,
      title: 'title test',
      body: 'body test',
    )
  ];

  test(
    'should get List of Posts from the repository',
    () async {
      repository = MockPostsRepository();
      usecase = GetPosts(repository);
      //stub the method
      when(repository.getPosts()).thenAnswer((_) async => const Right(tPosts));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, const Right(tPosts));
      verify(repository.getPosts());
      verifyNoMoreInteractions(repository);
    },
  );
}
