import 'package:Postly/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

abstract class PostlyFlushBar {
  static void showFloating(BuildContext context,
      {String title = "Title",
      String message = "message",
      Color backgroundColor = kPrimaryColor}) async {
    Flushbar(
      title: title,
      message: message,
      isDismissible: true,
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: backgroundColor,
      duration: Duration(seconds: 2),
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: EdgeInsets.all(8),
      borderRadius: 12,
    )..show(context);
  }
}
