import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Badge extends Equatable {
  const Badge({required this.name, required this.color});

  final String name;
  final Color color;

  @override
  List<Object?> get props => [name, color];
}

var beginnerBadge = const Badge(
  name: 'Beginner',
  color: Colors.orangeAccent,
);

var intermediateBadge = const Badge(
  name: 'Intermediate',
  color: Colors.blue,
);

var professionalBadge = const Badge(
  name: 'Professional',
  color: Colors.green,
);

var legendBadge = const Badge(
  name: 'Legend',
  color: Colors.purple,
);

class UserBadge {
  ///method to return user badge name and color
  Badge getUserBadge(int points) {
    if (points < 6) {
      return beginnerBadge;
    }

    if (points < 10) {
      return intermediateBadge;
    }

    if (points <= 16) {
      return professionalBadge;
    }

    return legendBadge;
  }
}
