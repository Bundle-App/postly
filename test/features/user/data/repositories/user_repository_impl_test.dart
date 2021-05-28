import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:postly/core/error/failure.dart';
import 'package:postly/features/user/data/datasources/user_local_data_source.dart';
import 'package:postly/features/user/data/datasources/user_remote_data_source.dart';
import 'package:postly/features/user/data/models/user_model.dart';
import 'package:postly/features/user/data/repositories/user_repository_impl.dart';
import 'package:postly/features/user/domain/entities/user.dart';

class MockUserRemoteDataSource extends Mock implements UserRemoteDataSource {}

class MockUserLocalDataSource extends Mock implements UserLocalDataSource {}

void main() {
  late MockUserRemoteDataSource mockRemoteDataSource;
  late MockUserLocalDataSource mockLocalDataSource;
  late UserRepositoryImpl repository;
  final tUserModel = UserModel(username: 'test');

  setUp(() {
    mockRemoteDataSource = MockUserRemoteDataSource();
    mockLocalDataSource = MockUserLocalDataSource();
    repository = UserRepositoryImpl(
      localDataSource: mockLocalDataSource,
      remoteDataSource: mockRemoteDataSource,
    );
  });

  group('getUser', () {
    final User tUser = tUserModel;

    test(
      'should return data when the call to remote data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getRemoteUser())
            .thenAnswer((_) async => tUserModel);
        when(mockLocalDataSource.hasCache()).thenReturn(false);

        // act
        final result = await repository.getUser();
        // assert
        verify(mockRemoteDataSource.getRemoteUser());

        expect(result, equals(Right(tUser)));
      },
    );

    test(
      'should call remote data when hasCache is false',
      () async {
        when(mockLocalDataSource.hasCache()).thenReturn(false);
        await repository.getUser();

        verify(mockRemoteDataSource.getRemoteUser());
      },
    );

    test(
      'should call local data when hasCache is true',
      () async {
        // act
        when(mockLocalDataSource.hasCache()).thenReturn(true);

        await repository.getUser();
        // assert
        verify(mockLocalDataSource.getCachedUser());
      },
    );

    test(
      'should return server failure when call to remote data is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getRemoteUser()).thenThrow(ServerException());
        when(mockLocalDataSource.hasCache()).thenReturn(false);

        // act
        final result = await repository.getUser();
        // assert
        verify(mockRemoteDataSource.getRemoteUser());
        expect(result, equals(Left(ServerFailure())));
      },
    );

    test(
      'should return last locally cached data when the cached data is present',
      () async {
        // arrange
        when(mockLocalDataSource.getCachedUser())
            .thenAnswer((_) async => tUserModel);
        // act
        final result = await repository.getUser();
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getCachedUser());
        expect(result, equals(Right(tUser)));
      },
    );

    test(
      'should return CacheFailure when there is no cached data present',
      () async {
        // arrange
        when(mockLocalDataSource.getCachedUser()).thenThrow(CacheException());
        when(mockLocalDataSource.hasCache()).thenReturn(true);

        // act
        final result = await repository.getUser();
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getCachedUser());
        expect(result, equals(Left(CacheFailure())));
      },
    );
  });
}
