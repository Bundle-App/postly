class UserBadge {
  String getUserBadge(int points) {
    if (points < 6) return 'Beginner';

    if (points < 10) return 'Intermediate';
    if (points <= 16) return 'Professional';

    return 'Legend';
  }
}
