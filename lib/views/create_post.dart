import 'package:Postly/utils/constants.dart';
import 'package:Postly/utils/responsiveness.dart';
import 'package:Postly/view_model/postly_view_model.dart';
import 'package:Postly/widget/post_text_field.dart';
// import 'package:Postly/view_model/base_view_model.dart';
// import 'package:Postly/widget/post_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatePostScreen extends StatelessWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PostlyViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Create Post'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: kSubTextColor,
                    radius: 25,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${vm.user.username}'),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_city,
                            size: 15,
                            color: kSubTextColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${vm.user.address.suite}, ${vm.user.address.street}, ${vm.user.address.city}',
                            style:
                                TextStyle(color: kSubTextColor, fontSize: 13),
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
                hintStyle: TextStyle(
                    color: kSubTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Divider(),
              PostTextField(
                  controller: postController,
                  maxLines: 5,
                  hintText: 'Type in your post here...',
                  hintStyle: TextStyle(
                    color: kSubTextColor,
                    fontSize: 13,
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 45,
                width: screenWidth(context),
                child: ElevatedButton(
                  onPressed: () {
                    vm.setPost = postController.text;
                    vm.setTitle = titleController.text;
                    vm.createPost(context);
                    postController.clear();
                    titleController.clear();
                  },
                  style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: vm.isLoading
                      ? Image.asset(
                          'assets/images/loader.gif',
                          height: 35,
                          color: Colors.white,
                        )
                      : Text('Create Post'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
