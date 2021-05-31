import 'package:dartz/dartz.dart';
import 'package:postly/features/user/domain/entities/posts.dart';

import '../../../../core/error/failure.dart';

///user repository abstraction
abstract class PostsRepository {
  ///method that gets lists of post or failure
  Future<Either<Failure, List<Posts>>> getPosts();
}
