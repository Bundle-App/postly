import 'package:Postly/configs/app_config.dart';
import 'package:Postly/di.dart';
import 'package:Postly/module/post/bloc/postly_bloc.dart';
import 'package:Postly/module/post/model/post/post.dart';
import 'package:Postly/utils/widgets/button.dart';
import 'package:Postly/utils/widgets/input_text.dart';
import 'package:flutter/material.dart';

class AddPost extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Post post = Post();
  @override
  Widget build(BuildContext context) {
    var labelStyle = TextStyle(
        fontSize: getTextSize(context, size: 17), fontWeight: FontWeight.w500);

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Post"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text("Title", style: labelStyle),
                SizedBox(height: 10),
                InputTextWidget(
                  hintText: "",
                  keyboardType: TextInputType.text,
                  onSaved: (String value) {
                    post.title = value;
                  },
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Post title is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                Text("Body", style: labelStyle),
                SizedBox(height: 10),
                InputTextWidget(
                  height: 150,
                  hintText: "",
                  keyboardType: TextInputType.text,
                  onSaved: (String value) {
                    post.body = value;
                  },
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Post body is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40),
                MyButton(
                  onTap: () {
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      ioc.get<PostlyBloc>().add(CreatePost(post: post));
                    }
                  },
                  height: 50.0,
                  width: double.infinity,
                  title: "Create Post",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
