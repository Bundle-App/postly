import 'package:Postly/data/data_provider/api_client.dart';
import 'package:Postly/data/repository/data_repository/post_services.dart';
import 'package:Postly/locator.dart';
import 'package:Postly/models/post.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class PostServicesMock extends Mock implements PostServices {}

// void _removeRegisterionIfExist<T>() {
//   if (locator.isRegistered<T>()) {
//     locator.unregister<T>();
//   }
// }

void main() {
  List<Post> testPosts = [
    Post(id: 1, userId: 2, title: "First Post", body: "First post to test"),
    Post(id: 2, userId: 2, title: "Second Post", body: "Second post to test"),
    Post(id: 3, userId: 2, title: "Third Post", body: "Third post to test"),
    Post(id: 4, userId: 2, title: "Four Post", body: "Four post to test"),
  ];
  PostServicesMock postService = PostServicesMock();

  test('Testing get post to see if it returns list of post object', () async {
    when(postService.getPosts()).thenAnswer((_) async => testPosts);
    var result = await postService.getPosts();
    expect(result, testPosts);
    verify(postService.getPosts());
    verifyNoMoreInteractions(postService);
  });

  // PostServicesMock getAndRegisterPostServiceMock({bool returnPosts = true}) {
  //   _removeRegisterionIfExist<PostServices>();
  //   when(service.getPosts()).thenAnswer((realInvocation) {
  //     async {
  //
  //     }
  //     //     if (returnPosts) return http.Response("""[
  //     // {
  //     //   "userId": 1,
  //     //   "id": 1,
  //     //   "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
  //     //   "body": "This is new"
  //     // },{
  //     //   "userId": 1,
  //     //   "id": 1,
  //     //   "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
  //     //   "body": "this is also new"
  //     // }]""", 200);
  //   });
  //   locator.registerSingleton<PostServices>(service);
  //   return service;
  // }

  // var _api = locator<PostServices>();
  //
  // test('getting post', () async {
  //   final result = await _api.getPosts();
  //
  //   expect(result, Post as List);
  // });
}

// test('returns a Map if there is no error', () async {
// ApiCli
// when(mockitoExample.get('https://jsonplaceholder.typicode.com/posts/1'))
// .thenAnswer((value) async {
// http.Response('{"title": "Test"}', 200);
// });
//
// expect(await fetchFromDatabase(mockitoExample), isA<Map>());
// });
