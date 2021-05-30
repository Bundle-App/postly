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
          builder: (_) => SplashScreen(),
        );
      case '/post':
        return MaterialPageRoute(
          builder: (_) => PostScreen(),
        );
      case '/create_post':
        return MaterialPageRoute(
          builder: (_) => CreatePostScreen(),
        );
      default:
        return null;
    }
  }
}
