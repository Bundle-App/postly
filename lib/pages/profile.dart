import 'package:postly/config/size_config.dart';
import 'package:postly/models/posts.dart';
import 'package:postly/controllers/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:postly/widgets/badge.dart';
import 'package:postly/widgets/suspense.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<UserController>(
        init: UserController(),
        builder: (controller) => POSTLYSuspense(
          appState: controller.appState,
          loadingWidget: Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: Center(
            child: Text("Shot something bad"),
          ),
          successWidget: (_) => Container(
            child: Container(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Badge(
                            points: controller.user.points,
                          ),
                          Text(controller.user.username),
                          Text(controller.user.points.toString()),
                          FlatButton(
                            onPressed: () {
                              Get.toNamed("/create_post").then(
                                (value) {
                                  if (value != null) {
                                    controller.addNewPost(value);
                                  }
                                },
                              );
                            },
                            child: Text("Create post"),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: ListView.builder(
                        itemCount: controller.posts.length,
                        itemBuilder: (context, index) {
                          Post posts = controller.posts[index];
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            margin: EdgeInsets.only(
                              bottom: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  posts.title,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(posts.body),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
