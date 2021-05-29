import 'package:Postly/models/user/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Badges', () {
    test('Beginner', () {
      final user = User(points: 3);
      expect(user.isBeginner, true);
      expect(user.badge, 'Beginner');
    });

    test('Intermediate', () {
      final user = User(points: 8);
      expect(user.isIntermediate, true);
      expect(user.badge, 'Intermediate');
    });

    test('Professional', () {
      final user = User(points: 12);
      expect(user.isProfessional, true);
      expect(user.badge, 'Professional');
    });

    test('Legend', () {
      final user = User(points: 25);
      expect(user.isLegend, true);
      expect(user.badge, 'Legend');
    });
  });
}
