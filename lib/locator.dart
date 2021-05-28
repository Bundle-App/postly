import 'package:Postly/data/repository/database/hive_repository.dart';
import 'package:get_it/get_it.dart';

import 'data/data_provider/api_client.dart';
import 'data/repository/data_repository/post_services.dart';
import 'data/repository/data_repository/user_services.dart';

GetIt locator = GetIt.instance;

Future<void> setUpLocator() async {
  locator.registerLazySingleton<HiveRepository>(() => HiveRepository());
  locator.registerLazySingleton<UserServices>(() => UserServices());
  locator.registerLazySingleton<PostServices>(() => PostServices());
  locator.registerLazySingleton<ApiClient>(() => ApiClient());
}
