part of 'badge_cubit.dart';

abstract class BadgeState {
  const BadgeState();
}

class BadgeInitial extends BadgeState {}

class BadgeBeginner extends BadgeState {}

class BadgeIntermediate extends BadgeState {}

class BadgeExpert extends BadgeState {}
