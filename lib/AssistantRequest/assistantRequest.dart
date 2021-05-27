import 'dart:convert';
import 'package:Postly/services/storage.dart';
import 'package:http/http.dart' as http;

class RequestAssistant {
  static Future<dynamic> getRequest(url) async {
    http.Response response = await http.get(
      url,
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
    );
    try {
      if (response.statusCode == 200) {
        String jsonData = response.body;
        var decodeData = jsonDecode(jsonData);
        return decodeData;
      } else {
        return 'Failed';
      }
    } catch (e) {
      return 'Failed';
    }
  }
}
