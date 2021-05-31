import 'package:Postly/configs/app_config.dart';
import 'package:Postly/di.dart';
import 'package:Postly/module/post/model/user/user.dart';
import 'package:Postly/utils/box_helper.dart';
import 'package:dio/dio.dart';

class PostService {
  Dio _dio;
  // setting the baseUrl for the jsonplaceholder server
  final String _baseUrl = AppConfig.baseUrl;
  PostService() {
    _dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
    ));
  }

  // Get All Users data from https://jsonplaceholder.typicode.com/users
  Future<Response> getUsers() {
    return _dio.get(AppConfig.getUserUrl);
  }

  // Get All Posts data from https://jsonplaceholder.typicode.com/post
  Future<Response> getPost() {
    return _dio.get(AppConfig.getPostUrl);
  }

  // Reset function:- this function reset current user point to zero after the user has already become a legend
  void resetPoint() {
    var currentUser = ioc.get<User>();
    currentUser.points = 0; // reset user's points to 0
    final userBox =
        BoxHelper<User>().getBox(AppConfig.userBoxName); // Open User's box
    // Update the user's data in the user's box
    userBox.putAt(0, currentUser);
  }
}

/*
adding [isSuccessful] prop to Response which allows to check if network request was successful
 */
extension ResponseExt on Response {
  bool get isSuccessful => statusCode >= 200 && statusCode < 300;
}
