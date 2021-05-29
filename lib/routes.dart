
import 'package:Postly/screen/create_post.dart';
import 'package:Postly/screen/homepage.dart';
import 'package:Postly/screen/initial_screen.dart';
import 'package:Postly/util/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> getRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case AppRoutes.initial:
        return CupertinoPageRoute(
            builder: (_) => InitialScreen());
      case AppRoutes.createPost:
        return CupertinoPageRoute(
            builder: (_) => CreatePost());

    }
  }
}
