import 'package:Postly/exceptions/exception.dart';
import 'package:Postly/models/http/response.dart';
import 'package:Postly/models/user/user.dart';
import 'package:Postly/states/auth/auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../commons/mocks.dart';

void main() {
  AuthState authState;
  MockAuthService authService;

  setUp(() {
    authService = MockAuthService();
    authState = AuthState(authService);
  });

  final user = User(id: 1, username: 'username');

  group('getUser-state', () {
    test('returns local user if exists', () async {
      when(authService.getLocalUser())
          .thenAnswer((realInvocation) => Future.value(user));

      expect(authState.user, isNull);
      await authState.getUser();
      expect(authState.user, isNotNull);
      expect(authState.user, user);

      verify(authService.getLocalUser());
      verifyNever(authService.getUser());
      verifyNever(authService.setLocalUser(any));
    });

    test('successfully returns remote if local does not exist', () async {
      when(authService.getLocalUser())
          .thenAnswer((realInvocation) => Future.value(null));
      when(authService.getUser()).thenAnswer(
        (realInvocation) => Future.value(
          SuccessResponse<User>(
            extraData: user,
          ),
        ),
      );
      when(authService.setLocalUser(user))
          .thenAnswer((realInvocation) => Future.value());

      expect(authState.user, isNull);
      await authState.getUser();
      expect(authState.user, isNotNull);
      expect(authState.user, user);

      verifyInOrder([
        authService.getLocalUser(),
        authService.getUser(),
        authService.setLocalUser(user),
      ]);
    });

    test('returns remote with failure if local does not exist', () async {
      when(authService.getLocalUser())
          .thenAnswer((realInvocation) => Future.value(null));
      when(authService.getUser()).thenAnswer(
        (realInvocation) => Future.value(
          FailureResponse<User>(message: 'failed'),
        ),
      );

      expect(authState.user, isNull);

      expect(
        () async => await authState.getUser(),
        throwsA(
          predicate((e) => e is CustomException && e.message == 'failed'),
        ),
      );

      expect(authState.user, isNull);

      verify(authService.getLocalUser());
      verifyNoMoreInteractions(authService);
    });
  });

  group('updatePoints-state', () {
    test('normal updatePoints behavior', () async {
      when(authService.setLocalUser(user))
          .thenAnswer((realInvocation) => Future.value(user));

      authState.user = user;

      expect(authState.user.points, 0);
      await authState.updatePoints();
      expect(authState.user.points, 2);

      verify(authService.setLocalUser(user.copyWith(points: 2)));
    });

    test('updatePoints clear behavior', () async {
      when(authService.setLocalUser(user))
          .thenAnswer((realInvocation) => Future.value(user));

      authState.user = user.copyWith(points: 4);

      expect(authState.user.points, 4);
      await authState.updatePoints(clearPoints: true);
      expect(authState.user.points, 0);

      verify(authService.setLocalUser(user.copyWith(points: 0)));
    });
  });
}
