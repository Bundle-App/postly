import 'package:Postly/module/post/bloc/postly_bloc.dart';
import 'package:Postly/module/post/service/post_service.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';

void main() {
  PostService httpService;
  PostlyBloc bloc;
  setUp(() {
    httpService = PostService();
    bloc = PostlyBloc();
  });

  tearDown(() {
    bloc.close();
  });

  group('Test User Service', () {
    test('Test fetch users from server', () async {
      var res = await httpService.getUsers();
      expect(res.isSuccessful, true);
      var data = res.data as List;
      expect(data.length > 0, true);
    });
    test("it should fail when trying to", () {});
  });

  group("Test Post Service", () {
    test('Test fetch users from server', () async {
      var res = await httpService.getPost();
      expect(res.isSuccessful, true);
      var data = res.data as List;
      expect(data.length > 0, true);
    });
  });

  group("Test for all the event handling in the bloc", () {
    test("the intial stat for the PostlyBloc is [PostInitial]", () {
      expect(bloc.state, PostInitial());
    });

    blocTest(
      'Emit [FetchedUser] when fetching users from the API server',
      build: () async => PostlyBloc(),
      // act: (bloc) => bloc
      //     .add(CreatePost(post: Post(title: "knlddn", body: "jndffjdfbdj"))),
      expect: [],
    );
  });
}
