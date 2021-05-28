import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

import '../../../../core/error/failure.dart';
import '../../../../core/utils/strings.dart';
import '../models/username_model.dart';

abstract class UsernameRemoteDataSource {
  Future<UsernameModel> getRemoteUsername();
}

class UsernameRemoteDataSourceImpl implements UsernameRemoteDataSource {
  UsernameRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<UsernameModel> getRemoteUsername() async {
    var baseUrl = Strings.baseUrl;
    var url = '$baseUrl/users';
    final response = await client.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      ///decode the response body into a string
      final parsed = json.decode(response.body);

      ///method to decode the model from a string to a list
      List<UsernameModel> usernameModelFromJson(String str) =>
          List<UsernameModel>.from(
              json.decode(str).map((x) => UsernameModel.fromJson(x)));
      final usernameModel = usernameModelFromJson(parsed);

      ///return random username
      return usernameModel.randomItem();
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
