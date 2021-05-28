import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:postly/features/user/data/models/user_model.dart';
import 'package:postly/features/user/domain/entities/user.dart';

import '../../../../data/data_reader.dart';

void main() {
  final tUserModel = UserModel(username: 'Test');

  test(
    'should be a subclass of User entity',
    () async {
      // assert
      expect(tUserModel, isA<User>());
    },
  );
  group('fromJson', () {
    test(
      'should return a valid model when fromJson is called',
      () async {
        final jsonString = dataReader('user.json');
        final Map<String, dynamic> jsonMap = json.decode(jsonString);
        final result = UserModel.fromJson(jsonMap);
        expect(result, tUserModel);
      },
    );
  });
  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tUserModel.toJson();
        // assert
        final expectedMap = {'username': 'Test'};
        expect(result, expectedMap);
      },
    );
  });
}
