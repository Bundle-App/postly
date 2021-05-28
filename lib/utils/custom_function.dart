class CustomFunction {
  /// Method responsible for determining the metric badge title of a user based
  /// on their accrued points
  String badgeMetric(int points) {
    if (points < 6) return "Beginner";

    if (points < 10) return "Intermediate";

    return "Professional";
  }
}
