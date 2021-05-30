import 'package:Postly/models/post/combined.dart';
import 'package:Postly/models/post/post.dart';
import 'package:Postly/screens/post/create.dart';
import 'package:Postly/states/auth/auth.dart';
import 'package:Postly/states/post/post.dart';
import 'package:Postly/theme/colors.dart';
import 'package:Postly/widgets/error.dart';
import 'package:Postly/widgets/legend_dialog.dart';
import 'package:Postly/widgets/post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostsScreen extends StatefulWidget {
  static String route = '/posts/index';

  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  Future<CombinedPosts> _postsFuture;

  @override
  void initState() {
    super.initState();
    _assignPostsFuture();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      final authState = context.read<AuthState>();
      final user = authState.user;
      if (!user.isLegend) return;

      await _onShowDialog(user.username);
      authState.updatePoints(clearPoints: true);
    });
  }

  void _assignPostsFuture({
    bool isRefresh = false,
    bool isRefreshLocal = false,
  }) {
    final postState = context.read<PostState>();

    _postsFuture = postState.getPosts(
      isRefresh: isRefresh,
      isRefreshLocal: isRefreshLocal,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      floatingActionButton: FloatingActionButton(
        backgroundColor: PostlyColors.bundlePurple,
        child: Icon(Icons.create),
        onPressed: _onCreatePost,
      ),
      body: SafeArea(
        child: FutureBuilder<CombinedPosts>(
          future: _postsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting &&
                !snapshot.hasData) {
              return Center(
                child: Container(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor:
                        AlwaysStoppedAnimation(PostlyColors.bundlePurple),
                  ),
                ),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: FutureErrorDisplay(
                  message: 'An error occurred while getting categories',
                  onRetry: () {
                    setState(() {
                      _assignPostsFuture();
                    });
                  },
                ),
              );
            }

            final data = snapshot.data;
            final createdByMe = data.createdByMe;
            final fetchedRemotely = data.fetchedRemotely;

            final hasCreatedByMe =
                createdByMe != null && createdByMe.isNotEmpty;

            final user = context.select((AuthState state) => state.user);

            return RefreshIndicator(
              color: PostlyColors.bundlePurple,
              onRefresh: _onRefreshScreen,
              child: ListView(
                children: [
                  Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 10),
                        CircleAvatar(
                          radius: 41,
                          backgroundColor: PostlyColors.bundlePurple,
                          child: Text(
                            '${user.username}'.substring(0, 1).toUpperCase(),
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          '@${user.username}',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          decoration: BoxDecoration(
                              color: user.badgeColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10)),
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          child: Text('${user.badge}'),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  if (hasCreatedByMe)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Text(
                        'MY POSTS',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.8)),
                      ),
                    ),
                  if (hasCreatedByMe) _buildList(createdByMe),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Text(
                      'ONLINE POSTS',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.8)),
                    ),
                  ),
                  _buildList(fetchedRemotely),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _onRefreshScreen() async {
    setState(() {
      _assignPostsFuture(isRefresh: true);
    });
  }

  Widget _buildList(List<Post> posts) {
    return ListView.builder(
      itemCount: posts.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final post = posts.elementAt(index);
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: PostTile(post: post),
        );
      },
    );
  }

  void _onCreatePost() async {
    final postCreated = await Navigator.pushNamed(
      context,
      CreatePostScreen.route,
    );
    if (postCreated == null || !postCreated) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Post created successfully'),
      ),
    );

    setState(() {
      _assignPostsFuture(isRefreshLocal: true);
    });
  }

  Future<void> _onShowDialog(String username) async{
    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: LegendDialog(
            username: username,
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: 16),
        );
      },
      barrierDismissible: true,
    );
  }
}
