import 'package:Postly/models/user/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Badges', () {
    User user = User(id: 1, username: 'username');

    test('Beginner', () {
      user = user.copyWith(points: 3);
      expect(user.isBeginner, true);
      expect(user.badge, 'Beginner');
    });

    test('Intermediate', () {
      user = user.copyWith(points: 8);
      expect(user.isIntermediate, true);
      expect(user.badge, 'Intermediate');
    });

    test('Professional', () {
      user = user.copyWith(points: 12);
      expect(user.isProfessional, true);
      expect(user.badge, 'Professional');
    });

    test('Legend', () {
      user = user.copyWith(points: 25);
      expect(user.isLegend, true);
      expect(user.badge, 'Legend');
    });
  });
}
