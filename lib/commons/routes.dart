import 'package:Postly/screens/dashboard.dart';
import 'package:Postly/screens/splash/splash.dart';
import 'package:flutter/material.dart';

final routeTable = <String, WidgetBuilder>{
  SplashScreen.route: (context) => SplashScreen(),
  DashboardScreen.route: (context) => DashboardScreen(),
};
