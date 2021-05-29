import 'package:dartz/dartz.dart';
import 'package:postly/features/user/domain/entities/posts.dart';
import 'package:postly/features/user/domain/repositories/posts_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';

class GetPosts extends UseCase<List<Posts>, NoParams> {
  GetPosts(this.repository);
  final PostsRepository repository;

  @override
  Future<Either<Failure, List<Posts>>> call(NoParams params) async {
    return await repository.getPosts();
  }
}
