import 'package:Postly/utils/constants.dart';
import 'package:flutter/material.dart';

class PostTextField extends StatelessWidget {
  PostTextField({
    @required this.controller,
    this.hintText,
  });

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 5,
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        hintStyle: TextStyle(color: kSubTextColor, fontSize: 13),
        contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        border: InputBorder.none,
      ),
    );
  }
}
