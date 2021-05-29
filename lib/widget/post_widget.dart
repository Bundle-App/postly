import 'package:Postly/model/post.dart';
import 'package:Postly/util/constants.dart';
import 'package:Postly/util/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.title.toInitialCaps(),
            style: TextStyle(
                color: AppColors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            post.body,
            style: TextStyle(
                color: AppColors.black,
                fontSize: 13,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 6,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              '9 May, 21',
              style: TextStyle(
                  color: AppColors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w300),
            ),
          )
        ],
      ),
    );
  }
}
