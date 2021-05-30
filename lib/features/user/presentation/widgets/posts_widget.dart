import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postly/core/utils/app_colors.dart';

import 'package:postly/features/user/presentation/notifiers/posts_state.dart';

import 'package:postly/features/user/presentation/screens/home.dart';

import '../../../../core/utils/extensions.dart';

class PostsWidget extends StatefulWidget {
  const PostsWidget({
    Key? key,
  }) : super(key: key);

  @override
  _PostsWidgetState createState() => _PostsWidgetState();
}

class _PostsWidgetState extends State<PostsWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )
      ..forward()
      ..addListener(() {
        setState(() {});
      });
    _animation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Consumer(builder: (context, watch, child) {
        var state = watch(postsProvider);
        if (state is PostsLoading) {
          return const CircularProgressIndicator();
        } else if (state is PostsLoaded) {
          //state.posts.sort((b, a) => a.id!.compareTo(b.id!));

          return Column(
            children: state.posts
                .map((e) => SlideTransition(
                      position: _animation,
                      child: Card(
                          elevation: 0,
                          color: AppColors.lightBrown,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.title.capitalize,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.semiBlack,
                                  ),
                                ),
                                SizedBox(height: context.screenWidth(0.05)),
                                Text(
                                  e.body.capitalize,
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          )),
                    ))
                .toList(),
          );
        } else if (state is PostsError) {
          return Text(state.message);
        }
        return Container();
      }),
    );
  }
}
