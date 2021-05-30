import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postly/core/utils/user_badge.dart';
import 'package:postly/features/user/presentation/notifiers/points_notifier.dart';
import 'package:postly/features/user/presentation/notifiers/posts_notifier.dart';
import 'package:postly/features/user/presentation/notifiers/posts_state.dart';
import 'package:postly/features/user/presentation/notifiers/user_notifier.dart';
import 'package:postly/features/user/presentation/notifiers/user_state.dart';
import 'package:postly/features/user/presentation/widgets/dialogs.dart';
import 'package:postly/features/user/presentation/widgets/posts_widget.dart';
import 'package:postly/features/user/presentation/widgets/user_widget.dart';

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
    context.read(pointsNotifier.notifier).fetchPoints();
    context.read(userProvider.notifier).fetchUser();
    context.read(postsProvider.notifier).fetchPosts();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      var points = context.read(pointsNotifier.notifier).currentPoint();
      if (points > 16) {
        messageDialog(
          context: context,
          onPressed: () {
            context.read(pointsNotifier.notifier).clear();
            Navigator.pop(context);
          },
          content: 'You are a postly legend!',
        );
      }
    });
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
          child: const Icon(Icons.add, color: Colors.white),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                ///shows current username and user's badge
                UserWidget(userBadge: userBadge),

                ///shows posts fetched
                const PostsWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
