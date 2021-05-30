import 'package:Postly/animation/blinking_widget.dart';
import 'package:Postly/utils/constants.dart';
import 'package:Postly/widget/postly_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class PopupDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return BackdropFilter(
      filter: ui.ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0)), //this right here
        child: Container(
          height: 350,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'You are a Postly\nLegend!',
                  textAlign: TextAlign.center,
                  style: kTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: kPrimaryColor),
                ),
                BlinkingWidget(
                  Image.asset('assets/images/legend.png'),
                ),
                PostlyButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Dismiss',
                    style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
