part of 'badge_cubit.dart';

abstract class BadgeState extends Equatable {
  const BadgeState();
}

class BadgeInitial extends BadgeState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class BadgeBeginner extends BadgeState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class BadgeIntermediate extends BadgeState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class BadgeProfessional extends BadgeState {
  final bool initial;
  final int points;

  BadgeProfessional(this.initial,this.points);
  @override
  // TODO: implement props
  List<Object> get props => [initial,points];
}
