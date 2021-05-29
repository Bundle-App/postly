import 'package:equatable/equatable.dart';
import 'package:postly/features/user/domain/entities/user.dart';

abstract class UserState extends Equatable {}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoaded extends UserState {
  UserLoaded(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}

class UserError extends UserState {
  UserError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
