import 'package:Postly/models/post/combined.dart';
import 'package:Postly/models/post/post.dart';
import 'package:Postly/states/post/post.dart';
import 'package:Postly/widgets/error.dart';
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
  }

  void _assignPostsFuture() {
    final postService = context.read<PostState>();
    _postsFuture = postService.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<CombinedPosts>(
        future: _postsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Container(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
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

          final hasCreatedByMe = createdByMe != null && createdByMe.isNotEmpty;

          return ListView(
            children: [
              if (hasCreatedByMe)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
          );
        },
      ),
    );
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
}
