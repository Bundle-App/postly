import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:postly/controllers/post.dart';
import 'package:postly/widgets/text_field.dart';
import '../extensions/num.dart';

class CreatePost extends StatelessWidget {
  final postNameController = TextEditingController();
  final postDescriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create post"),
        centerTitle: true,
      ),
      body: GetBuilder<PostController>(
        init: PostController(),
        builder: (controller) => Container(
          padding: EdgeInsets.symmetric(
            vertical: 2.h,
            horizontal: 2.h,
          ),
          child: Column(
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    POSTLYTextFormField(
                      textEditingController: postNameController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Field can not be empty";
                        }
                        return null;
                      },
                    ),
                    POSTLYTextFormField(
                      textEditingController: postDescriptionController,
                      maxLines: 5,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Field can not be empty";
                        }
                        return null;
                      },
                    ),
                    FlatButton(
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          controller.createPost(
                            postNameController.text,
                            postDescriptionController.text,
                          );
                        }
                      },
                      child: Text("Create"),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
