import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:postly/features/user/data/models/posts_model.dart';
import 'package:postly/features/user/domain/entities/posts.dart';

import '../../../../data/data_reader.dart';

void main() {
  final tPostsModel = PostsModel(id: 1, title: 'test', body: 'test body');

  test(
    'should be a subclass of Posts entity',
    () async {
      // assert
      expect(tPostsModel, isA<Posts>());
    },
  );
  group('fromJson', () {
    test(
      'should return a valid model when fromJson is called',
      () async {
        final jsonString = dataReader('posts.json');
        final Map<String, dynamic> jsonMap = json.decode(jsonString);
        final result = PostsModel.fromJson(jsonMap);
        expect(result, tPostsModel);
      },
    );
  });
  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tPostsModel.toJson();
        // assert
        final expectedMap = {'id': 1, 'title': 'test', 'body': 'test body'};
        expect(result, expectedMap);
      },
    );
  });
}
