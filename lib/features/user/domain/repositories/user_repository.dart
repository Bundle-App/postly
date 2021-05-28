import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/user.dart';

///user repository abstraction
abstract class UserRepository {
  ///method that gets user or failure
  Future<Either<Failure, User>> getUser();
}
