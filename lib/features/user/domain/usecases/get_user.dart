// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:postly/features/user/domain/entities/user.dart';
import 'package:postly/features/user/domain/repositories/user_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';

class GetUser extends UseCase<User, NoParams> {
  GetUser(this.repository);
  final UserRepository repository;

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.getUser();
  }
}
