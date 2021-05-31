import 'package:Postly/di.dart';
import 'package:Postly/module/post/bloc/postly_bloc.dart';
import 'package:Postly/module/post/model/post/post.dart';
import 'package:Postly/module/post/model/user/user.dart';
import 'package:Postly/module/post/service/post_service.dart';
import 'package:Postly/module/post/widgets/add_post.dart';
import 'package:Postly/module/post/widgets/add_post_button.dart';
import 'package:Postly/module/post/widgets/badge_notification_dialog.dart';
import 'package:Postly/module/post/widgets/list_loading.dart';
import 'package:Postly/module/post/widgets/post_list.dart';
import 'package:Postly/module/post/widgets/user_info.dart';
import 'package:Postly/utils/helpers/route_animation.dart';
import 'package:Postly/utils/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post> posts;
  @override
  void initState() {
    var points = ioc.get<User>().points;
    // if user's point is greater than 16 shows legend dialog box
    if (points > 16) {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return CustomDialogBox(
              child: BadgeNotification(
                onClosed: () {
                  ioc.get<PostService>().resetPoint();
                  Navigator.of(context).pop();
                  setState(() {});
                },
              ),
            );
          });
    }

    // get posts
    ioc.get<PostlyBloc>().add(GetPosts());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          UserInfo(),
          BlocBuilder(
            bloc: ioc.get<PostlyBloc>(),
            builder: (context, state) {
              if (state is FetchingPosts) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return ListLoadingWidget();
                      }),
                );
              }
              if (state is FetchedPosts) {
                posts = state.posts;
                return Expanded(
                  child: PostListView(
                    posts: posts,
                  ),
                );
              }
              return Expanded(
                child: PostListView(
                  posts: posts,
                ),
              );
            },
          )
        ],
      ),
      floatingActionButton: AddPostButton(onPressed: () async {
        Navigator.of(context).push(FadeRoute(page: AddPost()));
      }),
    );
  }
}
