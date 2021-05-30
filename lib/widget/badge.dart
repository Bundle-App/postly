import 'package:Postly/utils/constants.dart';
import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final String level;
  final String image;

  Badge({@required this.level, @required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          level,
          style: TextStyle(color: kSubTextColor, fontSize: 13),
        ),
        Image.asset(
          'assets/images/$image.png',
          scale: 4,
        ),
      ],
    );
  }
}
