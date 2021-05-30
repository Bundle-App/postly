import 'package:Postly/util/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final int minLines;
  final int maxLines;

  const MTextField(
      {Key key, @required this.label, @required this.controller, @required this.minLines, @required this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.grey,
          width: .2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            color: AppColors.primary.withOpacity(.1),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
              child: Text(
                label,
                style: TextStyle(color: AppColors.primary, fontSize: 13,fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15,1,15,10),
            child: TextField(
              controller: controller,
              minLines: minLines,
              maxLines: maxLines,
              style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          )
        ],
      ),
    );
  }
}
