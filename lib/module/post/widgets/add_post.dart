import 'package:Postly/configs/app_config.dart';
import 'package:Postly/di.dart';
import 'package:Postly/module/post/bloc/postly_bloc.dart';
import 'package:Postly/module/post/model/post/post.dart';
import 'package:Postly/utils/widgets/button.dart';
import 'package:Postly/utils/widgets/input_text.dart';
import 'package:Postly/utils/widgets/messenger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
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
          child: BlocConsumer(
            bloc: ioc.get<PostlyBloc>(),
            listener: (context, state) {
              if (state is CreatedPost) {
                // Send success message via snackbar
                MessengerWidget.sendMessage(
                    message: "Post created successfully", context: context);
              }

              if (state is CreatePostWithError) {
                // Send error message via snackbar

                MessengerWidget.sendMessage(
                    message: state.message,
                    context: context,
                    type: MessengerType.error);
              }
            },
            builder: (context, state) {
              return Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text("Title", style: labelStyle),
                    SizedBox(height: 10),
                    InputTextWidget(
                      hintText: "",
                      initialValue: post.title ?? "",
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
                      initialValue: post.title ?? "",
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
              );
            },
          ),
        ),
      ),
    );
  }
}
