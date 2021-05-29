import 'dart:convert';
import 'dart:io';

import 'package:Postly/exceptions/exception.dart';
import 'package:Postly/models/http/request.dart';
import 'package:Postly/models/http/response.dart';
import 'package:Postly/models/user/user.dart';
import 'package:Postly/services/http/http.dart';
import 'package:Postly/services/storage/simple.dart';
import 'package:logging/logging.dart';
import 'package:Postly/extensions/response_extension.dart';

abstract class AuthService {
  //get user from remote
  Future<ApiResponse<User>> getUser();

  //Function adds user if nonexistent, and otherwise, updates the user
  Future<void> setLocalUser(User user);

  //get user from local storage
  Future<User> getLocalUser();
}

class AuthServiceImpl implements AuthService {
  final _userStorageKey = 'user_object';
  final _log = Logger('AuthServiceImpl');

  final _unexpectedExceptionMessage = 'An error occurred unexpectedly';
  final _socketExceptionMessage =
      'Operation failed. Check your network and retry';

  final SimpleStorageService storage;
  final HttpService httpService;

  AuthServiceImpl(this.storage, this.httpService);

  @override
  Future<ApiResponse<User>> getUser() async {
    try {
      final request = JsonRequest(
        path: 'users',
      );

      final response = await httpService.get(request);
      final responseData = jsonDecode(response.body);

      if (!response.isSuccessful) {
        return FailureResponse.errorFromResponse(responseData);
      }

      final usersList = List<Map<String, dynamic>>.from(responseData);
      final chosenUser = User.fromJson(usersList.first);

      final result = SuccessResponse<User>(extraData: chosenUser);

      return result;
    } on SocketException catch (e, t) {
      _log.info('getUser', e);
      throw CustomException(_socketExceptionMessage);
    } on FormatException catch (e, t) {
      _log.info('getUser', e);
      throw CustomException(_unexpectedExceptionMessage);
    } catch (e, t) {
      _log.severe('getUser', e.stackTrace);
      throw CustomException(_unexpectedExceptionMessage);
    }
  }

  @override
  Future<void> setLocalUser(User user) async {
    await storage.putString(_userStorageKey, jsonEncode(user.toJson()));
  }

  @override
  Future<User> getLocalUser() async {
    final userString = await storage.getString(_userStorageKey);
    if (userString == null) return null;

    final userMap = jsonDecode(userString);
    final user = User.fromJson(userMap);

    return user;
  }
}
