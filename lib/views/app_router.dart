import 'package:Postly/views/create_post.dart';
import 'package:Postly/views/post_screen.dart';
import 'package:Postly/views/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    final GlobalKey<ScaffoldState> key = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => SplashScreen(
              // title: "Home Screen",
              // color: Colors.blueAccent,
              ),
        );
      case '/post':
        return MaterialPageRoute(
          builder: (_) => PostScreen(
              // title: "Second Screen",
              // color: Colors.redAccent,
              // homeScreenKey: key,
              ),
        );
      case '/create_post':
        return MaterialPageRoute(
          builder: (_) => CreatePostScreen(
              // title: "Thirst Screen",
              // color: Colors.greenAccent,
              ),
        );
      default:
        return null;
    }
  }
}
