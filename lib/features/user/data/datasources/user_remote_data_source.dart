import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

import '../../../../core/error/failure.dart';
import '../../../../core/utils/strings.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getRemoteUser();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  UserRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<UserModel> getRemoteUser() async {
    var baseUrl = Strings.baseUrl;
    var url = '$baseUrl/users';
    final response = await client.get(
      Uri.parse(url),
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

///random item from list extension
extension RandomListItem<T> on List<T> {
  T randomItem() {
    return this[Random().nextInt(length)];
  }
}
