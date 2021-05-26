// ignore: import_of_legacy_library_into_null_safe
import 'package:Postly/core/error/failure.dart';
import 'package:Postly/features/user/domain/entities/username.dart';
import 'package:dartz/dartz.dart';

abstract class UsernameRepository {
  Future<Either<Failure, Username>> getUsername();
}
