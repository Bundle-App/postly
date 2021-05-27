class CustomFunction {
  String badgeMetric(int points) {
    if (points < 6) return "Beginner";

    if (points < 10) return "Intermediate";

    return "Professional";
  }
}
