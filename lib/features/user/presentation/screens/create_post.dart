import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postly/core/utils/field_validator.dart';
import 'package:postly/core/utils/app_colors.dart';
import 'package:postly/features/user/presentation/widgets/appbar.dart';
import 'package:postly/features/user/presentation/widgets/dialogs.dart';
import 'package:postly/features/user/presentation/notifiers/posts_state.dart';
import '../../../../core/utils/extensions.dart';

import 'home.dart';

class CreatePost extends StatelessWidget {
  CreatePost({Key? key}) : super(key: key);
  final TextEditingController _title = TextEditingController();
  final TextEditingController _body = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 35, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// title label
                  const FormTitle(title: 'Enter Title'),

                  /// title form field
                  FormField(
                    title: _title,
                    hintText: 'Enter the title of your post',
                  ),

                  ///post label
                  const FormTitle(title: 'Post'),

                  ///post form field
                  FormField(
                    title: _body,
                    hintText: 'Write post',
                    maxLines: 5,
                  ),

                  ///create post button
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 30),
                      width: context.screenWidth(0.35),
                      height: context.screenWidth(0.12),
                      child: TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ///increase point by two
                            context.read(pointsNotifier.notifier).increment();

                            ///get current post
                            var post = context
                                .read(postsProvider.notifier)
                                .currentPost();
                            if (post is PostsLoaded) {
                              ///update post with user entered value
                              context.read(postsProvider.notifier).updatePosts(
                                    post: post.posts,
                                    id: post.posts.last.id! + 1,
                                    title: _title.text,
                                    body: _body.text,
                                  );
                            }

                            ///return success message on post creation
                            messageDialog(
                              context: context,
                              onPressed: () {
                                var count = 0;
                                Navigator.popUntil(
                                  context,
                                  (route) {
                                    return count++ == 2;
                                  },
                                );
                              },
                              content: 'Post created!',
                            );
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.brown,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Create Post',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FormField extends StatelessWidget {
  const FormField({
    Key? key,
    required this.title,
    required this.hintText,
    this.maxLines,
  }) : super(key: key);

  final TextEditingController title;
  final String hintText;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: title,
        maxLines: maxLines ?? 2,
        decoration: textInputDecoration.copyWith(hintText: hintText),
        validator: FieldValidator.validateText,
      ),
    );
  }
}

class FormTitle extends StatelessWidget {
  const FormTitle({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenWidth(0.05),
      child: Text(
        title,
        style: const TextStyle(
            color: AppColors.darkGrey, fontWeight: FontWeight.w600),
      ),
    );
  }
}

const textInputDecoration = InputDecoration(
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.borderBlack),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.borderBlack),
  ),
  errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
  focusedErrorBorder:
      OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
);
