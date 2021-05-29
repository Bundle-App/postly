import 'package:Postly/util/metrics.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group("Test to determine badge", () {
    final badge = BadgeMetric();
    test("< than 6 points : Beginner", () {
      int points = 3;

      String badgeMetric = badge.badge(points);

      expect(badgeMetric, 'Beginner');
    });

    test("< than 10 points: Intermediate", () {
      int points = 9;

      String badgeMetric = badge.badge(points);

      expect(badgeMetric, 'Intermediate');
    });

    test("10 to 16 points and above: Professional", () {
      int points = 15;

      String badgeMetric = badge.badge(points);

      expect(badgeMetric, 'Professional');
    });
  });
}
