import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart' as http;
import 'package:postly/core/error/failure.dart';
import 'package:postly/features/user/data/datasources/posts_remote_data_source.dart';
import 'package:postly/core/utils/extensions.dart';
import 'package:postly/features/user/data/models/posts_model.dart';

import '../../../../data/data_reader.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late MockClient client;
  late PostsRemoteDataSourceImpl dataSource;
  var url = Uri.parse('posts'.baseurl);
  setUp(() {
    client = MockClient();
    dataSource = PostsRemoteDataSourceImpl(client: client);
  });

  group('fetchPosts', () {
    test('returns a List of posts if the http call completes successfully',
        () async {
      when(client.get(url)).thenAnswer(
          (_) async => http.Response(dataReader('posts_list.json'), 200));

      expect(await dataSource.getRemotePosts(), isA<List<PostsModel>>());
    });

    test('throws an exception if the http call completes with an error', () {
      when(client.get(url))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(() => dataSource.getRemotePosts(),
          throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
