import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/error/failure.dart';
import '../../../../core/utils/extensions.dart';
import '../models/user_model.dart';

///this class makes calls directly to the api
abstract class UserRemoteDataSource {
  ///gets results from endpoint and returns the model
  ///or throws server exception if error
  Future<UserModel> getRemoteUser();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  UserRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<UserModel> getRemoteUser() async {
    final response = await client.get(
      Uri.parse('users'.baseurl),
    );

    if (response.statusCode == 200) {
      ///method to decode the model from a string to a list
      List<UserModel> userModelFromJson(String str) => List<UserModel>.from(
          json.decode(str).map((x) => UserModel.fromJson(x)));

      final userModel = userModelFromJson(response.body);

      ///return random user
      return userModel.randomItem();
    } else {
      throw ServerException();
    }
  }
}
