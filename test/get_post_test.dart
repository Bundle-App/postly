import 'package:Postly/data/repository/data_repository/post_services.dart';
import 'package:Postly/data/repository/database/hive_repository.dart';
import 'package:Postly/models/posts/post.dart';
import 'package:Postly/utils/constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class PostServicesMock extends Mock implements PostServices {}

class HiveRepositoryMock extends Mock implements HiveRepository {}

void main() {
  List<Post> testPosts = [
    Post(id: 1, userId: 2, title: "First Post", body: "First post to test"),
    Post(id: 2, userId: 2, title: "Second Post", body: "Second post to test"),
    Post(id: 3, userId: 2, title: "Third Post", body: "Third post to test"),
    Post(id: 4, userId: 2, title: "Four Post", body: "Four post to test"),
  ];
  PostServicesMock postService = PostServicesMock();
  HiveRepositoryMock hiveRepository = HiveRepositoryMock();

  group('Test to get post and store in local db', () {
    test('Testing get post to see if it returns list of post object', () async {
      when(postService.getPosts()).thenAnswer((_) async => testPosts);
      var result = await postService.getPosts();
      expect(result, testPosts);
      verify(postService.getPosts());
      verifyNoMoreInteractions(postService);
    });

    test('Test to add the post gotten from network into local database', () {
      when(hiveRepository.add<List<Post>>(key: kPosts, name: kPostBox))
          .thenAnswer((_) async => testPosts);

      hiveRepository.add<List<Post>>(key: kPosts, name: kPostBox);

      verify(hiveRepository.add<List<Post>>(key: kPosts, name: kPostBox));
      verifyNoMoreInteractions(hiveRepository);
    });
  });
}
