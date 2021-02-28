import 'package:get_it/get_it.dart';
import 'package:postly/services/storage/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/posts/post.dart';
import 'services/users/user.dart';

import 'services/http/index.dart';

final locator = GetIt.instance;
Future<void> setUpLocator() async {
  var instance = await SharedPreferences.getInstance();
  locator.registerLazySingleton<SharedPreferences>(() => instance);
  locator.registerLazySingleton<UserService>(() => UserService());
  locator.registerLazySingleton<Storage>(() => Storage());
  locator.registerLazySingleton<PostService>(() => PostService());
  locator.registerLazySingleton<ApiClient>(() => ApiClient());
}
