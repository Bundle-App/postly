import 'package:flutter/material.dart';

extension CustomContext on BuildContext {
  double screenHeight([double percent = 1]) =>
      MediaQuery.of(this).size.height * percent;

  double screenWidth([double percent = 1]) =>
      MediaQuery.of(this).size.width * percent;
}

extension StringExtensions on String {
  /// baseurl path
  String get baseurl => 'https://jsonplaceholder.typicode.com/$this';
}
