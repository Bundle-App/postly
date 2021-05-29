import 'package:Postly/screens/post/create.dart';
import 'package:Postly/screens/post/index.dart';
import 'package:Postly/screens/splash/splash.dart';
import 'package:flutter/material.dart';

final routeTable = <String, WidgetBuilder>{
  SplashScreen.route: (context) => SplashScreen(),
  PostsScreen.route: (context) => PostsScreen(),
  CreatePostScreen.route: (context) => CreatePostScreen(),
};
