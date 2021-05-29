import 'package:Postly/cubit/posts_cubit.dart';
import 'package:Postly/util/constants.dart';
import 'package:Postly/widget/custom_button.dart';
import 'package:Postly/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  TextEditingController titleControl = new TextEditingController();
  TextEditingController bodyControl = new TextEditingController();
  bool loading = false;

  processNewPost() async {
    setState(() {
      loading = true;
    });
    String title = titleControl.value.text;
    String body = bodyControl.value.text;
    String response =
        await context.read<PostsCubit>().saveLocalPost(title, body);
    setState(() {
      loading = false;
    });
    if (response.isEmpty) {
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(msg: response);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'What\'s happening?',
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
                            controller: titleControl,
                            label: 'TITLE',
                            minLines: 1,
                            maxLines: 1,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          MTextField(
                            controller: bodyControl,
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
        ),
        if (loading)
          Positioned(top: 0, right: 0, left: 0, bottom: 0, child: _loader())
      ],
    );
  }

  Widget _loader() => Container(
        color: AppColors.white.withOpacity(.4),
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(AppColors.primary),
            strokeWidth: 1,
          ),
        ),
      );

  Widget _savePost() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40),
        child: MButton(text: 'Post', onClick: processNewPost, fillWidth: true),
      );
}
