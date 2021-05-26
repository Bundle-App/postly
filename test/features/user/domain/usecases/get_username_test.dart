// ignore: import_of_legacy_library_into_null_safe
import 'package:Postly/core/usecases/usecase.dart';
import 'package:Postly/features/user/domain/entities/username.dart';
import 'package:Postly/features/user/domain/repositories/username_repository.dart';
import 'package:Postly/features/user/domain/usecases/get_username.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUsernameRepository extends Mock implements UsernameRepository {}

void main() {
  MockUsernameRepository repository;
  GetUsername usecase;
  final tUsername = Username(
    'Mamus',
  );

  test(
    'should get Username from the repository',
    () async {
      repository = MockUsernameRepository();
      usecase = GetUsername(repository);
      //stub the method
      when(repository.getUsername()).thenAnswer((_) async => Right(tUsername));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, Right(tUsername));
      verify(repository.getUsername());
      verifyNoMoreInteractions(repository);
    },
  );
}
