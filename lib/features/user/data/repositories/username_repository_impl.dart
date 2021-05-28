import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/username.dart';
import '../../domain/repositories/username_repository.dart';
import '../datasources/username_local_data_source.dart';
import '../datasources/username_remote_data_source.dart';

class UsernameRepositoryImpl implements UsernameRepository {
  UsernameRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  final UsernameRemoteDataSource remoteDataSource;
  final UsernameLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, Username>> getUsername() async {
    var hasCache = localDataSource.hasCache();

    return await getUsernameSwitchCase(hasCache);
  }

  Future<Either<Failure, Username>> getUsernameSwitchCase(bool hasCache) async {
    switch (hasCache) {
      case true:
        return await localData();
      case false:
        return await remoteData();
      default:
        return await localData();
    }
  }

  Future<Either<Failure, Username>> remoteData() async {
    try {
      final remote = await remoteDataSource.getRemoteUsername();
      await localDataSource.cacheUsername(remote);
      return Right(remote);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, Username>> localData() async {
    try {
      final local = await localDataSource.getCachedUsername();
      return Right(local);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
