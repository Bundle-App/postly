import 'dart:convert';

import 'package:Postly/models/http/request.dart';
import 'package:http/http.dart' as http;

abstract class HttpService {
  Future<http.Response> post(JsonRequest request);
  Future<http.Response> get(JsonRequest request);
}

class HttpServiceImpl implements HttpService {
  final String baseUrl;

  HttpServiceImpl(this.baseUrl);

  @override
  Future<http.Response> get(JsonRequest request) async {
    try {
      final uri = Uri.parse('$baseUrl/${request.path}');
      final response = await http.get(
        uri,
        headers: request.headers,
      );

      return response;
    } catch (e, t) {
      rethrow;
    }
  }

  @override
  Future<http.Response> post(JsonRequest request) async {
    try {
      final uri = Uri.parse('$baseUrl/${request.path}');
      final response = await http.post(
        uri,
        body: jsonEncode(request.payload),
        headers: request.headers,
      );

      return response;
    } catch (e, t) {
      rethrow;
    }
  }
}
