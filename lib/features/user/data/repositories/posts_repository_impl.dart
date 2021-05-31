import 'package:dartz/dartz.dart';
import 'package:postly/features/user/data/datasources/posts_local_data_source.dart';
import 'package:postly/features/user/data/datasources/posts_remote_data_source.dart';
import 'package:postly/features/user/domain/entities/posts.dart';
import 'package:postly/features/user/domain/repositories/posts_repository.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';

class PostsRepositoryImpl implements PostsRepository {
  PostsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  final PostsRemoteDataSource remoteDataSource;
  final PostsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<Posts>>> getPosts() async {
    var isConnected = await networkInfo.isConnected;
    return await getPostsSwitchCase(isConnected);
  }

  Future<Either<Failure, List<Posts>>> getPostsSwitchCase(
      bool isConnected) async {
    switch (isConnected) {
      case true:
        return await remoteData();
      case false:
        return await localData();
      default:
        return await remoteData();
    }
  }

  Future<Either<Failure, List<Posts>>> remoteData() async {
    try {
      final remote = await remoteDataSource.getRemotePosts();
      await localDataSource.cacheLastPost(remote);
      return Right(remote);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, List<Posts>>> localData() async {
    try {
      final local = await localDataSource.getCachedPosts();
      return Right(local);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
