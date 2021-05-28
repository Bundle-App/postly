import 'package:Postly/constant/url.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function onPress;
  final String btnText;
  final Color color;
  final Color txtColor;

  const CustomButton(
      {Key key,
      this.onPress,
      this.btnText,
      this.color = blueColor,
      this.txtColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 65.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30), topRight: Radius.circular(30)),
            color: color),
        child: MaterialButton(
          onPressed: onPress,
          child: Container(
              child: Text(
            btnText,
            style: TextStyle(
                color: txtColor, fontSize: 22, fontWeight: FontWeight.w700),
          )),
          elevation: 0,
          minWidth: 400,
          height: 50,
        ),
      ),
    );
  }
}
