import 'package:Postly/utils/constants.dart';
import 'package:flutter/material.dart';

class PostTextField extends StatelessWidget {
  PostTextField({
    @required this.controller,
    this.hintText,
    this.maxLines = 1,
    this.hintStyle,
  });

  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final TextStyle hintStyle;

  @override
  Widget build(BuildContext context) {
    // TextStyle hintStyle = TextStyle(color: kSubTextColor, fontSize: 13);
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        hintStyle: hintStyle,
        contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        border: InputBorder.none,
      ),
    );
  }
}
