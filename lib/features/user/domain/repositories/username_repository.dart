import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/username.dart';

///username repository abstraction
abstract class UsernameRepository {
  ///method that gets username or failure
  Future<Either<Failure, Username>> getUsername();
}
