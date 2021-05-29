//This is to determine badge metrics
class BadgeMetric {
  String badge(int points) {
    if (points < 6) return "Beginner";

    if (points < 10) return "Intermediate";

    return "Professional";
  }
}
