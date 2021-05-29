part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInactive extends UserState {
  final String error;
  UserInactive({this.error});
  @override
  List<Object> get props => [error];
}

class UserProcessing extends UserState {
  @override
  List<Object> get props => [];
}

class UserActive extends UserState {
  User user;
  UserActive(this.user);
  @override
  List<Object> get props => [user];
}
