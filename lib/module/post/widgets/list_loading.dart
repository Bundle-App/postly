import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class ListLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SkeletonAnimation(
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Color(0xFFDBDAE3),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
          Column(
            children: [
              SkeletonAnimation(
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Color(0xFFDBDAE3),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              SkeletonAnimation(
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Color(0xFFDBDAE3),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
