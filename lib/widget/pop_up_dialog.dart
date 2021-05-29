import 'package:Postly/animation/blinking_widget.dart';
import 'package:Postly/utils/responsiveness.dart';
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
          height: 100,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('You are a postly legend'),
                      BlinkingWidget(
                          Image.asset('assets/images/legend.png', scale: 4)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
