import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  static String route = '/dashboard';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  int _activePage;
  @override
  void initState() {
    super.initState();
    _activePage = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _activePage == 0 ? PostsScreen() : ProfileScreen(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (page) {
          _activePage = page;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: _activePage == 0
                  ? Colors.blue
                  : Colors.black.withOpacity(0.7),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _activePage == 1
                  ? Colors.blue
                  : Colors.black.withOpacity(0.7),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
