import 'package:Postly/util/font.dart';
import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final bool obscure;
  final String text;
  final TextEditingController controller;
  final String Function(String) validator;
  final Widget suffixIcon;
  final String prefixText;
  final TextInputType textInputType;
  final Function onSaved;
  final int maxline;
  const TextFieldContainer(
      {Key key,
      this.text,
      this.controller,
      this.validator,
      this.obscure,
      this.suffixIcon,
      this.prefixText,
      this.textInputType,
      this.onSaved,
      this.maxline})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: notoSansTextStyle(16.0, 0xff222222, FontWeight.w300),
      maxLines: maxline,
      controller: controller,
      validator: validator,
      keyboardType: textInputType,
      obscureText: obscure,
      onSaved: onSaved,
      decoration: InputDecoration(
          prefixText: prefixText,
          suffixIcon: text == 'Password' ? suffixIcon : SizedBox(),
          labelText: text,
          hasFloatingPlaceholder: false,
          filled: true,
          fillColor: Colors.blueGrey[50],
          labelStyle: notoSansTextStyle(20.0, 0xff222222, FontWeight.w300),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10.0))),
    );
  }
}

class TextFieldContainer1 extends StatelessWidget {
  final bool obscure;
  final String text;
  final TextEditingController controller;
  final String Function(String) validator;
  final Widget suffixIcon;
  final TextInputType textInputType;
  final Function onSaved;
  const TextFieldContainer1(
      {Key key,
      this.text,
      this.controller,
      this.validator,
      this.obscure,
      this.suffixIcon,
      this.textInputType,
      this.onSaved})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: notoSansTextStyle(16.0, 0xffffffff, FontWeight.w300),
      controller: controller,
      validator: validator,
      keyboardType: textInputType,
      obscureText: obscure,
      onSaved: onSaved,
      cursorColor: Colors.white,
      decoration: InputDecoration(
          suffixIcon: text == 'Password' ? suffixIcon : SizedBox(),
          labelText: text,
          hasFloatingPlaceholder: false,
          // filled: true,
          focusColor: Colors.red,
          labelStyle: notoSansTextStyle(10.0, 0xffffffff, FontWeight.w300),
          border:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffffffff)),
              borderRadius: BorderRadius.circular(0.0)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xffffffff),
              ),
              borderRadius: BorderRadius.circular(0.0))),
    );
  }
}
