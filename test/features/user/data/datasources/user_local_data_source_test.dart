import 'dart:convert';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:postly/core/error/failure.dart';
import 'package:postly/core/utils/strings.dart';
import 'package:postly/features/user/data/datasources/user_local_data_source.dart';
import 'package:postly/features/user/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/data_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockPref;
  late UserLocalDataSourceImpl dataSource;
  final tUserModel = UserModel(username: 'test');

  setUp(() {
    mockPref = MockSharedPreferences();
    dataSource = UserLocalDataSourceImpl(mockPref);
  });

  group('GetCache', () {
    test('Return UserModel when cache is available', () async {
      when(mockPref.getString(Strings.cachedUserString))
          .thenReturn(dataReader('user.json'));

      expect(await dataSource.getCachedUser(), isA<UserModel>());
    });

    test('Return cacheException when no cache is available', () async {
      when(mockPref.getString(Strings.cachedUserString)).thenReturn(null);

      expect(() => dataSource.getCachedUser(),
          throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group('cacheUser', () {
    test(
      'should call SharedPreferences to cache the data',
      () async {
        // act
        await dataSource.cacheUser(tUserModel);
        // assert
        final expectedJsonString = json.encode(tUserModel.toJson());
        verify(mockPref.setString(
          Strings.cachedUserString,
          expectedJsonString,
        ));
      },
    );
  });

  group('hasCache', () {
    test(
      'should return true when cache is available',
      () async {
        // act
        when(mockPref.getString(Strings.cachedUserString))
            .thenReturn(dataReader('user.json'));
        expect(dataSource.hasCache(), true);
      },
    );

    test(
      'should return false when cache is empty/null',
      () async {
        // act
        when(mockPref.getString(Strings.cachedUserString)).thenReturn(null);
        expect(dataSource.hasCache(), false);
      },
    );
  });
}
