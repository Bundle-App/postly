import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

//api call request
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
        var decodeData = jsonDecode(response.body);
        return decodeData;
      } else {
        return 'Failed';
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
