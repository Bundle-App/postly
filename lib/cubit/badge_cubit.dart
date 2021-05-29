import 'package:Postly/repo/badge_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'badge_state.dart';

class BadgeCubit extends Cubit<BadgeState> {
  BadgeRepo badgeRepo;

  BadgeCubit(this.badgeRepo) : super(BadgeInitial());
  int points = 0;

  void initBadge() async {
    points = await badgeRepo.getPoints();
    setBadge(initial: true);
  }

  Future<void> addToPoints() async {
    points += 2;
    await badgeRepo.savePoints(points);
    setBadge();
  }

  Future<void> resetPoints() async {
    points = 0;
    await badgeRepo.savePoints(points);
    setBadge();
  }

  void setBadge({bool initial = false}) {
    points < 6
        ? emit(BadgeBeginner())
        : points < 10
            ? emit(BadgeIntermediate())
            : emit(BadgeProfessional(initial, points));
  }
}
