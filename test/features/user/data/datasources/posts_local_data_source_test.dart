import 'dart:convert';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:postly/core/error/failure.dart';
import 'package:postly/core/utils/strings.dart';
import 'package:postly/features/user/data/datasources/posts_local_data_source.dart';
import 'package:postly/features/user/data/models/posts_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/data_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockPref;
  late PostsLocalDataSourceImpl dataSource;

  setUp(() {
    mockPref = MockSharedPreferences();
    dataSource = PostsLocalDataSourceImpl(mockPref);
  });
  final tPostsModel = [
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
  group('GetCache', () {
    test('Return List<PostsModel> when cache is available', () async {
      when(mockPref.getString(Strings.cachedPostsString))
          .thenReturn(dataReader('posts_list.json'));

      expect(await dataSource.getCachedPosts(), isA<List<PostsModel>>());
    });

    test('Return cacheException when no cache is available', () async {
      when(mockPref.getString(Strings.cachedPostsString)).thenReturn(null);

      expect(() => dataSource.getCachedPosts(),
          throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group('cacheLastPosts', () {
    test(
      'should call SharedPreferences to cache the data',
      () async {
        // act
        await dataSource.cacheLastPost(tPostsModel);
        // assert
        final expectedJsonString =
            json.encode(List<dynamic>.from(tPostsModel.map((x) => x.toJson())));
        verify(mockPref.setString(
          Strings.cachedPostsString,
          expectedJsonString,
        ));
      },
    );
  });
}
