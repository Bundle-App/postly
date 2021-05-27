import 'package:Postly/utils/custom_function.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group("Metrics for determining badge", () {
    final customFunction = CustomFunction();
    test("Less than 6 points : Beginner", () {
      int points = 5;

      String badgeMetric = customFunction.badgeMetric(points);

      expect(badgeMetric, "Beginner");
    });

    test("Less than 10 points: Intermediate", () {
      int points = 8;

      String badgeMetric = customFunction.badgeMetric(points);

      expect(badgeMetric, "Intermediate");
    });

    test("10 to 16 points and above: Professional", () {
      int points = 16;

      String badgeMetric = customFunction.badgeMetric(points);

      expect(badgeMetric, "Professional");
    });
  });
}
