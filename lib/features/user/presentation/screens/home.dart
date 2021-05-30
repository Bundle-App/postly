import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postly/core/utils/user_badge.dart';
import 'package:postly/features/user/presentation/notifiers/points_notifier.dart';
import 'package:postly/features/user/presentation/notifiers/posts_notifier.dart';
import 'package:postly/features/user/presentation/notifiers/posts_state.dart';
import 'package:postly/features/user/presentation/notifiers/user_notifier.dart';
import 'package:postly/features/user/presentation/notifiers/user_state.dart';

import '../../../../core/utils/extensions.dart';
import '../../../../service_locator.dart' as di;
import 'create_post.dart';

//create providers
final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  return di.sl<UserNotifier>();
});

final postsProvider = StateNotifierProvider<PostsNotifier, PostsState>((ref) {
  return di.sl<PostsNotifier>();
});

final pointsNotifier = StateNotifierProvider((ref) => di.sl<PointsNotifier>());

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  UserBadge userBadge = UserBadge();
  @override
  void initState() {
    super.initState();
    context.read(userProvider.notifier).fetchUser();
    context.read(postsProvider.notifier).fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CreatePost()),
            );
          },
          tooltip: 'Create new post',
          child: const Icon(Icons.add),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(height: context.screenHeight(0.05)),
                const Text(
                  'Postly',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: context.screenHeight(0.05)),
                Consumer(
                  builder: (context, watch, child) {
                    var state = watch(userProvider);
                    var points = watch(pointsNotifier);

                    if (state is UserLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is UserLoaded) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.user.username,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(width: context.screenWidth(0.05)),
                          Container(
                            padding: const EdgeInsets.all(10),
                            color: Colors.blue,
                            child: Text(
                              userBadge.getUserBadge(points),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      );
                    } else if (state is UserError) {
                      return Text(state.message);
                    }
                    return Container();
                  },
                ),
                SizedBox(height: context.screenHeight(0.05)),
                Consumer(builder: (context, watch, child) {
                  var state = watch(postsProvider);
                  if (state is PostsLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is PostsLoaded) {
                    return Column(
                      children: state.posts
                          .map((e) => Card(
                                  child: ListTile(
                                title: Text(
                                  e.title,
                                  maxLines: 1,
                                ),
                                subtitle: Text(
                                  e.body,
                                  maxLines: 3,
                                ),
                              )))
                          .toList(),
                    );
                  } else if (state is PostsError) {
                    return Text(state.message);
                  }
                  return Container();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
