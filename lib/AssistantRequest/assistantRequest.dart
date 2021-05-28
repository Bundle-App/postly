import 'dart:convert';

import 'package:flutter/services.dart';
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
        var decodeData = jsonDecode(response.body);
        return decodeData;
      } else {
        return 'Failed';
      }
    } on PlatformException catch (e) {
      print(e.toString());
      return 'Failed';
    }
  }
}
