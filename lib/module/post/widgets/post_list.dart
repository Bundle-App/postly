import 'package:Postly/configs/app_config.dart';
import 'package:Postly/module/post/model/post/post.dart';
import 'package:flutter/material.dart';

class PostListView extends StatelessWidget {
  final List<Post> posts;
  PostListView({this.posts});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: postList,
        builder: (context, value, child) {
          var newPost = [...posts, ...value];
          return ListView.builder(
              itemCount: newPost.length,
              itemBuilder: (context, index) {
                return PostItem(post: newPost[index]);
              });
        });

    // return ListView.builder(
    //     itemCount: posts.length,
    //     itemBuilder: (context, index) {
    //       return PostItem(post: posts[index]);
    //     });
  }
}

class PostItem extends StatelessWidget {
  final Post post;
  PostItem({this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.title,
            style: TextStyle(
                fontSize: getTextSize(context, size: 20),
                fontWeight: FontWeight.w500),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Text(
            post.body,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: getTextSize(
              context,
              size: 17,
            )),
          ),
          Divider(),
        ],
      ),
    );
  }
}
