import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart' as http;
import 'package:postly/core/error/failure.dart';
import 'package:postly/core/utils/extensions.dart';
import 'package:postly/features/user/data/datasources/user_remote_data_source.dart';
import 'package:postly/features/user/data/models/user_model.dart';

import '../../../../data/data_reader.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late MockClient client;
  late UserRemoteDataSourceImpl dataSource;

  var url = Uri.parse('users'.baseurl);

  setUp(() {
    client = MockClient();
    dataSource = UserRemoteDataSourceImpl(client: client);
  });

  group('fetchUser', () {
    test('returns User if the http call completes successfully', () async {
      when(client.get(url)).thenAnswer(
          (_) async => http.Response(dataReader('user_list.json'), 200));

      expect(await dataSource.getRemoteUser(), isA<UserModel>());
    });

    test('throws an exception if the http call completes with an error', () {
      when(client.get(url))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(() => dataSource.getRemoteUser(),
          throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
