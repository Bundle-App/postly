import 'package:Postly/utils/constants.dart';
import 'package:Postly/utils/margins.dart';
import 'package:Postly/view_model/postly_view_model.dart';
import 'package:Postly/widget/post_text_field.dart';
import 'package:Postly/widget/postly_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatePostScreen extends StatelessWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PostlyViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Create Post',
          style: kAppBarTextStyle,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  PostlyProfilePicture(),
                  XMargin(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${viewModel.user.username}',
                        style: kTextStyle,
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
                            '${viewModel.user.address.suite}, ${viewModel.user.address.street}, ${viewModel.user.address.city}',
                            style: kSubTextStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Divider(),
              PostTextField(
                controller: titleController,
                hintText: 'An interesting title',
                hintStyle: kHintTextStyle.copyWith(
                    fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Divider(),
              PostTextField(
                controller: postController,
                maxLines: 5,
                hintText: 'Type in your post here...',
                hintStyle: kHintTextStyle,
              ),
              YMargin(10),
              PostlyButton(
                viewModel: viewModel,
                postController: postController,
                titleController: titleController,
                onPressed: () {
                  viewModel.setPost = postController.text;
                  viewModel.setTitle = titleController.text;
                  viewModel.createPost(context);
                  postController.clear();
                  titleController.clear();
                },
                child: viewModel.isLoading
                    ? Image.asset(
                        'assets/images/loader.gif',
                        height: 35,
                        color: Colors.white,
                      )
                    : Text(
                        'Create Post',
                        style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PostlyProfilePicture extends StatelessWidget {
  const PostlyProfilePicture({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: kSubTextColor,
      radius: 25,
      child: Icon(
        Icons.person,
        color: Colors.white,
      ),
    );
  }
}
