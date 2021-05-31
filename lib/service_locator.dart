import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:postly/features/user/domain/usecases/get_posts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/user/data/datasources/posts_local_data_source.dart';
import 'features/user/data/datasources/posts_remote_data_source.dart';
import 'features/user/data/datasources/user_local_data_source.dart';
import 'features/user/data/datasources/user_remote_data_source.dart';
import 'features/user/data/repositories/posts_repository_impl.dart';
import 'features/user/data/repositories/user_repository_impl.dart';
import 'features/user/domain/repositories/posts_repository.dart';
import 'features/user/domain/repositories/user_repository.dart';
import 'features/user/domain/usecases/get_user.dart';
import 'features/user/presentation/notifiers/points_notifier.dart';
import 'features/user/presentation/notifiers/posts_notifier.dart';
import 'features/user/presentation/notifiers/user_notifier.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ///notifiers
  sl.registerLazySingleton<UserNotifier>(
    () => UserNotifier(sl()),
  );
  sl.registerLazySingleton<PostsNotifier>(
    () => PostsNotifier(sl()),
  );

  sl.registerLazySingleton<PointsNotifier>(
    () => PointsNotifier(sl()),
  );

  ///remote data source
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<PostsRemoteDataSource>(
    () => PostsRemoteDataSourceImpl(client: sl()),
  );

  ///local data source
  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(
      sl(),
    ),
  );

  sl.registerLazySingleton<PostsLocalDataSource>(
    () => PostsLocalDataSourceImpl(
      sl(),
    ),
  );

  ///usecase
  sl.registerLazySingleton(() => GetUser(sl()));
  sl.registerLazySingleton(() => GetPosts(sl()));

  ///repository

  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<PostsRepository>(
    () => PostsRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  /// Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /// External
  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
