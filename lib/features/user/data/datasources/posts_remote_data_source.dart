import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:postly/core/error/failure.dart';
import 'package:postly/features/user/data/models/posts_model.dart';

import '../../../../core/utils/extensions.dart';

abstract class PostsRemoteDataSource {
  Future<List<PostsModel>> getRemotePosts();
}

class PostsRemoteDataSourceImpl implements PostsRemoteDataSource {
  PostsRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<List<PostsModel>> getRemotePosts() async {
    final response = await client.get(
      Uri.parse('posts'.baseurl),
    );

    if (response.statusCode == 200) {
      ///decode and convert to a list of model
      List<PostsModel> postsModelFromJson(String str) => List<PostsModel>.from(
          json.decode(str).map((x) => PostsModel.fromJson(x)));

      return postsModelFromJson(response.body);
    } else {
      throw ServerException();
    }
  }
}
