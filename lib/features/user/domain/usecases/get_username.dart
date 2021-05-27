// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:postly/features/user/domain/entities/username.dart';
import 'package:postly/features/user/domain/repositories/username_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';

class GetUsername extends UseCase<Username, NoParams> {
  GetUsername(this.repository);
  final UsernameRepository repository;

  @override
  Future<Either<Failure, Username>> call(NoParams params) async {
    return await repository.getUsername();
  }
}
