import 'dart:math';

import 'package:flutter/material.dart';

extension CustomContext on BuildContext {
  ///extension method to get screen height based on current context

  double screenHeight([double percent = 1]) =>
      MediaQuery.of(this).size.height * percent;

  ///extension method to get screen width based on current context
  double screenWidth([double percent = 1]) =>
      MediaQuery.of(this).size.width * percent;
}

extension StringExtensions on String {
  ///extension method to get baseurl path
  String get baseurl => 'https://jsonplaceholder.typicode.com/$this';

  ///extension method capitalize the first letter of a sentence
  String get capitalize =>
      isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : '';
}

extension RandomListItem<T> on List<T> {
  ///extension method to return random item from list
  T randomItem() {
    return this[Random().nextInt(length)];
  }
}
