import 'package:Postly/exceptions/exception.dart';
import 'package:Postly/models/http/response.dart';
import 'package:Postly/models/user/user.dart';
import 'package:Postly/services/auth/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';

class AuthState with ChangeNotifier {
  final AuthService authService;

  AuthState(
    this.authService,
  );

  final _log = Logger('AuthState');

  User? _user;
  User? get user => _user;

  set user(User? user) {
    _user = user;
    notifyListeners();
  }

  Future<void> getUser() async {
    final localUser = await authService.getLocalUser();
    if (localUser != null) {
      this.user = localUser;
      return;
    }

    final response = await authService.getUser();
    if (!response.isSuccessful) {
      throw CustomException(response.message!);
    }

    this.user = response.extraData;
    authService.setLocalUser(this.user!);
  }

  Future<void> updatePoints({bool clearPoints = false}) async {
    final currentUser = this.user;
    if (currentUser == null) return;

    final currentPoints = currentUser.points;

    final updatedUser = currentUser.copyWith(
      points: clearPoints ? 0 : currentPoints + 2,
    );

    await authService.setLocalUser(updatedUser);
    this.user = updatedUser;
  }
}
