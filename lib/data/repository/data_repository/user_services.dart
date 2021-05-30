import 'package:Postly/data/data_provider/api_client.dart';
import 'package:Postly/models/user/user.dart';

import '../../../locator.dart';

class UserServices {
  var _apiClient = locator<ApiClient>();

  Future<List<User>> getUsers() async {
    try {
      final data = await _apiClient.get("users");
      var users = (data as List).map((e) => User.fromJson(e)).toList();
      return users;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
