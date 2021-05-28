import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final String badge;
  Badge(this.badge);
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10.0),
        child: Text(
          badge,
          style: TextStyle(fontSize: 20.0),
        ));
  }
}
