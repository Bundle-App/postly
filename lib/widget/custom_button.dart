import 'package:Postly/util/constants.dart';
import 'package:flutter/material.dart';

class MButton extends StatelessWidget {
  final String text;
  final String image;
  final Function onClick;
  final bool fillWidth;

  const MButton({Key key, @required this.text, this.image, @required this.onClick, @required this.fillWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: AppColors.primary,
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 5),
                  color: AppColors.primary.withOpacity(.3),
                  blurRadius: 15,
                  spreadRadius: 5)
            ]),
        alignment: fillWidth ? Alignment.center : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                  color: AppColors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
            ),
            if (image != null) ...[
              SizedBox(
                width: 6,
              ),
              Image.asset(
                image,
                color: AppColors.white,
                height: 13,
              )
            ]
          ],
        ),
      ),
    );
  }
}
