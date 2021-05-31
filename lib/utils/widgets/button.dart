import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final double height;
  final double width;
  final String title;
  final Function onTap;

  MyButton({
    @required this.height,
    @required this.title,
    @required this.width,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: this.height,
        width: this.width,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(50.0))),
        child: Center(
            child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        )),
      ),
    );
  }
}
