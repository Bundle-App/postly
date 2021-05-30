import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SimpleStorageService {
  FutureOr<bool> putString(String key, String value);
  FutureOr<String?> getString(String key);
}

class SecureStorageService implements SimpleStorageService {
  final FlutterSecureStorage secureStorageEngine;

  SecureStorageService(this.secureStorageEngine);

  @override
  FutureOr<String?> getString(String key) async {
    final result = await secureStorageEngine.read(key: key);
    return result;
  }

  @override
  FutureOr<bool> putString(String key, String value) async {
    await secureStorageEngine.write(key: key, value: value);
    return true;
  }
}
