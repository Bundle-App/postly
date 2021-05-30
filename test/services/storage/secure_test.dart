import 'dart:convert';
import 'dart:io';

import 'package:Postly/commons/strings.dart';
import 'package:Postly/exceptions/exception.dart';
import 'package:Postly/models/http/request.dart';
import 'package:Postly/models/http/response.dart';
import 'package:Postly/models/user/user.dart';
import 'package:Postly/services/storage/simple.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:http/http.dart' as http;
import '../../commons/json_loader.dart';
import '../../commons/mocks.dart';

void main() {
  late SecureStorageService storageService;
  late MockFlutterSecureEngine storageEngine;
  final _key = 'key';
  final _value = 'value';

  setUp(() {
    storageEngine = MockFlutterSecureEngine();
    storageService = SecureStorageService(storageEngine);
  });

  test('getString: verify', () async {
    when(storageEngine.read(key: _key))
        .thenAnswer((realInvocation) => Future.value(''));
    await storageService.getString(_key);
    verify(storageEngine.read(key: _key));
    verifyNoMoreInteractions(storageEngine);
  });

  test('putString: verify', () async {
    when(storageEngine.read(key: _key))
        .thenAnswer((realInvocation) => Future.value(''));
    await storageService.putString(_key, _value);
    verify(storageEngine.write(key: _key, value: _value));
    verifyNoMoreInteractions(storageEngine);
  });
}
