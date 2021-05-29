import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postly/core/error/failure.dart';
import 'package:postly/features/user/domain/usecases/get_user.dart';
import 'package:postly/features/user/presentation/notifiers/user_state.dart';
import '../../../../core/usecases/usecase.dart';

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier(this.allUser) : super(UserInitial());

  final GetUser allUser;

  void fetchUser() async {
    state = UserLoading();
    final result = await allUser(NoParams());
    result.fold(
      (failure) => state = UserError(mapFailureToMessage(failure)),
      (result) => state = UserLoaded(result),
    );
  }

  String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'No user found';
      case CacheFailure:
        return 'No internet connection ';
      default:
        return 'Unexpected error';
    }
  }
}
