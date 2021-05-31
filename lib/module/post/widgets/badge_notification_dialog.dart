import 'package:Postly/configs/app_config.dart';
import 'package:Postly/module/post/widgets/user_info.dart';
import 'package:flutter/material.dart';

class BadgeNotification extends StatelessWidget {
  final VoidCallback onClosed;
  BadgeNotification({this.onClosed});
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(
        child: Container(
            padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
            margin: EdgeInsets.only(top: 10),
            height: 220,
            width: 200,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: Offset(0, 10),
                      blurRadius: 10),
                ]),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 10),
                      Image.asset(
                        "assets/images/${UserBadge.professional.imageBadge}",
                        height: 120,
                        width: 120,
                      ),
                      Text(
                        "You are a Legend",
                        style: TextStyle(
                            fontSize: getTextSize(context, size: 19),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 146,
                  bottom: 170,
                  child: CloseButton(onPressed: onClosed),
                )
              ],
            )),
      ),
    ]);
  }
}
