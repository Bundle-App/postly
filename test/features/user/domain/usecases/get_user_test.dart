import 'package:postly/core/usecases/usecase.dart';
import 'package:postly/features/user/domain/entities/user.dart';
import 'package:postly/features/user/domain/repositories/user_repository.dart';
import 'package:postly/features/user/domain/usecases/get_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  MockUserRepository repository;
  GetUser usecase;
  const tUser = User(
    username: 'Mamus',
  );

  test(
    'should get User from the repository',
    () async {
      repository = MockUserRepository();
      usecase = GetUser(repository);
      //stub the method
      when(repository.getUser()).thenAnswer((_) async => const Right(tUser));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, const Right(tUser));
      verify(repository.getUser());
      verifyNoMoreInteractions(repository);
    },
  );
}
