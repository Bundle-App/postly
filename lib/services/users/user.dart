import 'package:postly/services/http/index.dart';
import 'package:postly/setUp.dart';

class UserService {
  var _apiClient = locator<ApiClient>();

  getUsers() async {
    return _apiClient.get("/users");
  }
}
