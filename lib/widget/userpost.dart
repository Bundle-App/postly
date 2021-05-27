import 'package:Postly/models/post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userPost = Provider.of<Post>(context);
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Color(0xffffffff),
        boxShadow: [
          BoxShadow(
              //blurRadius: 4,
              color: Colors.grey,
              offset: Offset(0, 2),
              spreadRadius: 0.5)
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 10.0),
            alignment: Alignment.topLeft,
            child: Text(
              userPost.title,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              userPost.body,
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
