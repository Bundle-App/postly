import 'package:http/http.dart' as http;
import 'package:postly/config/constants.dart';

class ApiClient {
  Future<http.Response> get(String url) async {
    Map<String, String> headers = ApiConstants.headers;
    print("${ApiConstants.BASE_URL}$url");
    var response = await http.get(
      "${ApiConstants.BASE_URL}$url",
      headers: headers,
    );
    return response;
  }
}
