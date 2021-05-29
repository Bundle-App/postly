import 'package:Postly/screens/post/index.dart';
import 'package:Postly/screens/profile/index.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  static String route = '/dashboard';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: PostsScreen(),
    );
  }
}
