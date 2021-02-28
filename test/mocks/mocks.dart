import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:postly/services/posts/post.dart';
import 'package:postly/services/storage/index.dart';
import 'package:postly/services/users/user.dart';
import 'package:postly/setUp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class HttpProvider {
  Future<Response> post(String url,
      {Map<String, String> headers, dynamic body});

  Future<Response> patch(String url,
      {Map<String, String> headers, dynamic body});

  void close();
}

class SharedPrefrencesMock extends Mock implements SharedPreferences {}

class UserServiceMock extends Mock implements UserService {}

class PostServiceMock extends Mock implements PostService {}

class StorageServiceMock extends Mock implements Storage {}

SharedPreferences getAndRegisterSharePrefrencesMock() {
  _removeRegisterionIfExist<SharedPreferences>();
  var service = SharedPrefrencesMock();
  locator.registerSingleton<SharedPreferences>(service);
  return service;
}

UserServiceMock getAndRegisterUserServiceMock({bool returnUserInfo = true}) {
  _removeRegisterionIfExist<UserService>();
  var service = UserServiceMock();
  when(service.getUsers()).thenAnswer((realInvocation) {
    if (returnUserInfo) return http.Response("""
    [
  {
    "id": 1,
    "name": "Leanne Graham",
    "username": "Bret",
    "email": "Sincere@april.biz",
    "address": {
      "street": "Kulas Light",
      "suite": "Apt. 556",
      "city": "Gwenborough",
      "zipcode": "92998-3874",
      "geo": {
        "lat": "-37.3159",
        "lng": "81.1496"
      }
    },
    "phone": "1-770-736-8031 x56442",
    "website": "hildegard.org",
    "company": {
      "name": "Romaguera-Crona",
      "catchPhrase": "Multi-layered client-server neural-net",
      "bs": "harness real-time e-markets"
    }
  },{
    "id": 1,
    "name": "Leanne Graham",
    "username": "Bret",
    "email": "Sincere@april.biz",
    "address": {
      "street": "Kulas Light",
      "suite": "Apt. 556",
      "city": "Gwenborough",
      "zipcode": "92998-3874",
      "geo": {
        "lat": "-37.3159",
        "lng": "81.1496"
      }
    },
    "phone": "1-770-736-8031 x56442",
    "website": "hildegard.org",
    "company": {
      "name": "Romaguera-Crona",
      "catchPhrase": "Multi-layered client-server neural-net",
      "bs": "harness real-time e-markets"
    }
  }]
  """, 200);
    return null;
  });
  locator.registerSingleton<UserService>(service);
  return service;
}

StorageServiceMock getAndRegisterStorageServiceMock() {
  var service = StorageServiceMock();
  locator.registerSingleton<Storage>(service);
  return service;
}

PostServiceMock getAndRegisterPostServiceMock({bool returnPosts = true}) {
  _removeRegisterionIfExist<PostService>();
  var service = PostServiceMock();
  when(service.getPost()).thenAnswer((realInvocation) {
    if (returnPosts) return http.Response("""[
  {
    "userId": 1,
    "id": 1,
    "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
    "body": "This is new"
  },{
    "userId": 1,
    "id": 1,
    "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
    "body": "this is also new"
  }]""", 200);
  });
  locator.registerSingleton<PostService>(service);
  return service;
}

void _removeRegisterionIfExist<T>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}

void registerServices() {
  getAndRegisterUserServiceMock();
  getAndRegisterSharePrefrencesMock();
  getAndRegisterPostServiceMock();
  getAndRegisterStorageServiceMock();
}

void unregisterServices() {
  locator.unregister<SharedPreferences>();
  locator.unregister<UserService>();
  locator.unregister<PostService>();
  locator.unregister<Storage>();
}
