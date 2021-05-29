import 'package:Postly/util/constants.dart';
import 'package:Postly/widget/custom_button.dart';
import 'package:Postly/widget/custom_textfield.dart';
import 'package:flutter/material.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Say Something',
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.close,
                      color: AppColors.grey,
                      size: 20,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      MTextField(
                        controller: TextEditingController(),
                        label: 'TITLE',
                        minLines: 1,
                        maxLines: 1,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      MTextField(
                        controller: TextEditingController(),
                        label: 'STORY',
                        minLines: 5,
                        maxLines: 7,
                      )
                    ],
                  ),
                ),
              ),

              _savePost()
            ],
          ),
        ),
      ),
    );
  }

  Widget _savePost() => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 40),
    child: MButton(text: 'Post', onClick: () {}, fillWidth: true),
  );
}
