import 'package:Postly/services/auth/auth.dart';
import 'package:Postly/services/http/http.dart';
import 'package:Postly/services/post/post.dart';
import 'package:Postly/services/storage/post_storage.dart';
import 'package:Postly/services/storage/simple.dart';
import 'package:Postly/states/auth/auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mockito/mockito.dart';
import 'package:sembast/sembast.dart';

class MockFlutterSecureEngine extends Mock implements FlutterSecureStorage {}

class MockStoreRef extends Mock implements StoreRef {}

class MockRecordRef extends Mock implements RecordRef {}

class MockSimpleStorage extends Mock implements SimpleStorageService {}

class MockPostStorage extends Mock implements PostStorageService {}

class MockHttpService extends Mock implements HttpService {}

class MockAuthService extends Mock implements AuthService {}

class MockPostService extends Mock implements PostService {}

class MockAuthState extends Mock implements AuthState {}
