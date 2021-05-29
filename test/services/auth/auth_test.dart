import 'dart:convert';
import 'dart:io';

import 'package:Postly/commons/strings.dart';
import 'package:Postly/exceptions/exception.dart';
import 'package:Postly/models/http/request.dart';
import 'package:Postly/models/http/response.dart';
import 'package:Postly/models/user/user.dart';
import 'package:Postly/services/auth/auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:http/http.dart' as http;
import '../../commons/json_loader.dart';
import '../../commons/mocks.dart';

void main() {
  AuthService authService;
  MockSimpleStorage storage;
  MockHttpService httpService;

  setUp(() {
    storage = MockSimpleStorage();
    httpService = MockHttpService();

    authService = AuthServiceImpl(storage, httpService);
  });

  group('getUser', () {
    List<dynamic> _rawUsers;
    List<User> _users;
    final request = JsonRequest(
      path: 'users',
    );

    setUp(() async {
      final usersString = await readJson('users.json');
      _rawUsers = jsonDecode(usersString);
      _users = _rawUsers.map((rawUser) => User.fromJson(rawUser)).toList();
    });

    test('getUser returns API user successfully', () async {
      final responseBody = _rawUsers;

      final mockResponse = http.Response(jsonEncode(responseBody), 200);

      when(httpService.get(request))
          .thenAnswer((realInvocation) => Future.value(mockResponse));

      //success return
      final response = await authService.getUser();
      expect(response, isInstanceOf<SuccessResponse<User>>());

      //first user in list is picked
      final retrievedUser = response.extraData;
      expect(retrievedUser, _users.first);
      expect(retrievedUser, isNot(_users.elementAt(1)));
    });

    test('getUser returns with API failure', () async {
      final responseBody = {'message': 'Error from API'};
      final mockResponse = http.Response(
        jsonEncode(responseBody),
        400,
      );

      when(httpService.get(request))
          .thenAnswer((realInvocation) => Future.value(mockResponse));

      //failure return
      final response = await authService.getUser();
      expect(response, isInstanceOf<FailureResponse<User>>());

      final message = response.message;
      expect(message, responseBody['message']);
    });

    test('getUser returns with exceptions', () async {
      when(httpService.get(request)).thenThrow(SocketException('Socket'));
      expect(
        () async => await authService.getUser(),
        throwsA(
          predicate((e) =>
              e is CustomException &&
              e.message == PostlyStrings.socketExceptionMessage),
        ),
      );

      when(httpService.get(request)).thenThrow(FormatException('Format'));
      expect(
        () async => await authService.getUser(),
        throwsA(
          predicate((e) =>
              e is CustomException &&
              e.message == PostlyStrings.unexpectedExceptionMessage),
        ),
      );

      when(httpService.get(request)).thenThrow(Exception('General'));
      expect(
        () async => await authService.getUser(),
        throwsA(
          predicate((e) =>
              e is CustomException &&
              e.message == PostlyStrings.unexpectedExceptionMessage),
        ),
      );
    });
  });

  group('setLocalUser', () {
    final user = User(id: 1, username: 'test');

    test('verify call', () async {
      await authService.setLocalUser(user);
      verify(
        storage.putString(
          PostlyStrings.userStorageKey,
          jsonEncode(user.toJson()),
        ),
      );
      verifyNoMoreInteractions(storage);
    });
  });

  group('getLocalUser', () {
    final user = User(id: 1, username: 'test');

    test('returns user if existent', () async {
      when(storage.getString(PostlyStrings.userStorageKey)).thenAnswer(
          (realInvocation) => Future.value(jsonEncode(user.toJson())));

      final localUser = await authService.getLocalUser();
      verify(storage.getString(PostlyStrings.userStorageKey));
      verifyNoMoreInteractions(storage);
      expect(localUser, user);

    });

    test('returns null if non-existent', () async {
      when(storage.getString(PostlyStrings.userStorageKey))
          .thenAnswer((realInvocation) => Future.value(null));

      final localUser = await authService.getLocalUser();
      verify(storage.getString(PostlyStrings.userStorageKey));
      verifyNoMoreInteractions(storage);
      expect(localUser, null);
    });
  });
}
