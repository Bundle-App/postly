import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:postly/core/utils/user_badge.dart';

void main() {
  var userBadge = UserBadge();

  group('User Badge', () {
    test('Should return beginner if points is 0', () {
      var result = userBadge.getUserBadge(0);
      expect(
        result,
        Badge(
          name: 'Beginner',
          color: Colors.orangeAccent,
        ),
      );
    });

    test('Should return Intermediate if points is 6', () {
      var result = userBadge.getUserBadge(6);
      expect(
        result,
        Badge(
          name: 'Intermediate',
          color: Colors.blue,
        ),
      );
    });

    test('Should return Professional if points is 10', () {
      var result = userBadge.getUserBadge(10);
      expect(
        result,
        Badge(
          name: 'Professional',
          color: Colors.green,
        ),
      );
    });

    test('Should return Professional if points is 16', () {
      var result = userBadge.getUserBadge(16);
      expect(
        result,
        Badge(
          name: 'Professional',
          color: Colors.green,
        ),
      );
    });

    test('Should return Legend if points is 18', () {
      var result = userBadge.getUserBadge(18);
      expect(
        result,
        Badge(
          name: 'Legend',
          color: Colors.purple,
        ),
      );
    });
  });
}
