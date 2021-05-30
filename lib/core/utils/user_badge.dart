import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Badge extends Equatable {
  Badge({required this.name, required this.color});

  final String name;
  final Color color;

  @override
  List<Object?> get props => [name, color];
}

class UserBadge {
  ///method to return user badge name and color
  Badge getUserBadge(int points) {
    if (points < 6) {
      return Badge(
        name: 'Beginner',
        color: Colors.orangeAccent,
      );
    }

    if (points < 10) {
      return Badge(
        name: 'Intermediate',
        color: Colors.blue,
      );
    }

    if (points <= 16) {
      return Badge(
        name: 'Professional',
        color: Colors.green,
      );
    }

    return Badge(
      name: 'Legend',
      color: Colors.purple,
    );
  }
}
