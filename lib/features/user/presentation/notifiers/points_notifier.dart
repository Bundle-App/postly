import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postly/core/utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PointsNotifier extends StateNotifier<int> {
  PointsNotifier(this.sharedPreference) : super(0);
  final SharedPreferences sharedPreference;

  void increment() {
    state = state + 2;
    sharedPreference.setInt(Strings.cachedPointsString, state);
  }

  void clear() {
    state = 0;
    sharedPreference.remove(Strings.cachedPointsString);
  }
}
