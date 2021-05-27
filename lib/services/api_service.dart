import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  /// This method handles making a get request to the defined API to fetch posts
  /// to be displayed to the user
  Future<dynamic> getPosts() async {
    try {
      http.Response response =
          await http.get("https://jsonplaceholder.typicode.com/posts");

      if (response.statusCode == 200) {
        String data = response.body;

        return jsonDecode(data);
      } else {
        print("getPosts: Something went wrong. Try again");
        throw ("Something went wrong. Try again");
      }
    } on SocketException {
      print("getPosts: Please check you internet connection");
      throw ("Please check your internet connection");
    } catch (e) {
      print("getPosts: $e");
    }
  }

  /// This method handles making a get request to a defined API to fetch a list
  /// of users
  Future<dynamic> getUser() async {
    try {
      http.Response response =
          await http.get("https://jsonplaceholder.typicode.com/users");

      if (response.statusCode == 200) {
        String data = response.body;

        return jsonDecode(data);
      } else {
        print("getUser: Something went wrong. Try again");
        throw ("Something went wrong. Try again");
      }
    } on SocketException {
      print("getUser: Please check your internet connection");
      throw ("Please check your internet connection");
    } catch (e) {
      print("getUser: $e");
    }
  }
}
