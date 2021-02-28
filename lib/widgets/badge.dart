import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:postly/extensions/num.dart';

class Badge extends StatelessWidget {
  final int points;

  const Badge({Key key, this.points}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (points < 6) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.05),
          borderRadius: BorderRadius.circular(50),
        ),
        padding: EdgeInsets.all(10),
        child: LineIcon.beer(
          size: 6.text,
        ),
      );
    } else if (points < 10) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.05),
          borderRadius: BorderRadius.circular(50),
        ),
        padding: EdgeInsets.all(10),
        child: LineIcon.facebook(
          size: 6.text,
        ),
      );
    } else if (points > 10 || points <= 16) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.yellow.withOpacity(0.05),
          borderRadius: BorderRadius.circular(50),
        ),
        padding: EdgeInsets.all(10),
        child: LineIcon.lockOpen(
          size: 6.text,
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.05),
          borderRadius: BorderRadius.circular(50),
        ),
        padding: EdgeInsets.all(10),
        child: LineIcon.desktop(
          size: 6.text,
        ),
      );
    }
  }
}
