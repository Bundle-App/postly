import 'package:Postly/util/font.dart';
import 'package:flutter/material.dart';

class Connection extends StatelessWidget {
  static const routeName = 'connection';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wifi_off),
          Text('No Internet Connection',
              style: notoSansTextStyle(14.0, 0xff222222, FontWeight.bold)),
        ],
      ),
    ));
  }
}
