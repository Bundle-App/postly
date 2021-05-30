import 'package:Postly/models/posts/post.dart';
import 'package:Postly/utils/constants.dart';
import 'package:Postly/utils/margins.dart';
import 'package:Postly/view_model/postly_view_model.dart';
import 'package:Postly/views/create_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<PostlyViewModel>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, CREATE_POST_ROUTE);
        },
        backgroundColor: kPrimaryColor,
        child: Icon(Icons.note_add_outlined),
      ),
      appBar: AppBar(
        toolbarHeight: 120,
        title: Text(
          'Post',
          style: kAppBarTextStyle,
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(100.0), // here the desired height
          child: Container(
            color: kBackground,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: Row(
                children: [
                  PostlyProfilePicture(),
                  XMargin(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${viewModel.user.username}',
                            style: kTextStyle,
                          ),
                          XMargin(5),
                          CircleAvatar(
                            radius: 2.0,
                            backgroundColor: Colors.black,
                          ),
                          XMargin(5),
                          Text('${viewModel.viewPoints.toString()}'),
                        ],
                      ),
                      YMargin(5),
                      Row(
                        children: [
                          Icon(
                            Icons.location_city,
                            size: 15,
                            color: kSubTextColor,
                          ),
                          XMargin(5),
                          Text(
                            '${viewModel.user.address.street}, ${viewModel.user.address.city}',
                            style: kSubTextStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  // returns the badge depending on the user's score
                  viewModel.badge()
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            YMargin(10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: viewModel.posts.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  Post post = viewModel.posts[index];
                  return Card(
                    child: ListTile(
                      minLeadingWidth: 20,
                      leading: Icon(Icons.notes),
                      title: Text(post.title),
                      subtitle: Text(post.body),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
