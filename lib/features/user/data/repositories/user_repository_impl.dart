import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_local_data_source.dart';
import '../datasources/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;

  @override
  Future<Either<Failure, User>> getUser() async {
    var hasCache = localDataSource.hasCache();

    return await getUserSwitchCase(hasCache);
  }

  Future<Either<Failure, User>> getUserSwitchCase(bool hasCache) async {
    switch (hasCache) {
      case true:
        return await localData();
      case false:
        return await remoteData();
      default:
        return await localData();
    }
  }

  Future<Either<Failure, User>> remoteData() async {
    try {
      final remote = await remoteDataSource.getRemoteUser();
      await localDataSource.cacheUser(remote);
      return Right(remote);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, User>> localData() async {
    try {
      final local = await localDataSource.getCachedUser();
      return Right(local);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
