import 'package:Postly/bloc/postly_bloc.dart';
import 'package:Postly/events/postly_events.dart';
import 'package:Postly/model/post.dart';
import 'package:Postly/utils/colors.dart';
import 'package:Postly/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreatePost extends StatefulWidget {
  static String id = 'create_post';
  const CreatePost({Key key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final FocusNode _titleNode = FocusNode();
  final FocusNode _bodyNode = FocusNode();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();

  String _userInputTitle = "";
  String _userInputBody = "";

  void _titleControllerListener() {
    _userInputTitle = _titleController.text.trim();
  }

  void _bodyControllerListener() {
    _userInputBody = _bodyController.text.trim();
  }

  /// Method responsible for displaying a toast message
  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 5,
      textColor: Colors.white,
      backgroundColor: Color(0xff210A54),
      gravity: ToastGravity.TOP,
    );
  }

  /// Method that validates that the text fields for the "title" and "body" is
  /// not empty, if not, publishes the new post and then pops back to the home
  /// screen
  void createPostHandler() {
    if (_userInputTitle.length < 1 && _userInputBody.length < 1) {
      showToast("Both fields cannot be empty");
    } else if (_userInputTitle.length < 1) {
      showToast("Please input a title");
    } else if (_userInputBody.length < 1) {
      showToast("Please add a content body");
    } else {
      Post newPost = Post(title: _userInputTitle, body: _userInputBody);
      BlocProvider.of<PostlyBloc>(context)
          .add(CreatePostEvent(newPost: newPost));

      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();

    _titleController.addListener(_titleControllerListener);
    _bodyController.addListener(_bodyControllerListener);
  }

  @override
  void dispose() {
    _titleNode.dispose();
    _bodyNode.dispose();
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kAccentColor,
          title: Text(
            "Create post",
            style: kAppBarStyle,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  onSubmitted: (text) {
                    _titleNode.unfocus();
                    FocusScope.of(context).requestFocus(_bodyNode);
                  },
                  autofocus: true,
                  focusNode: _titleNode,
                  textInputAction: TextInputAction.next,
                  maxLines: null,
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: "Title",
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: kAccentColor, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 18.0,
                ),
                Divider(),
                SizedBox(
                  height: 18.0,
                ),
                TextField(
                  controller: _bodyController,
                  onSubmitted: (text) {
                    _bodyNode.unfocus();
                  },
                  focusNode: _bodyNode,
                  textInputAction: TextInputAction.done,
                  maxLines: null,
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: "Body",
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: kAccentColor, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    /// Cancel button
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(kCatchyColor),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 20.0),
                        ),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: 24.0,
                    ),

                    /// Post button
                    TextButton(
                      onPressed: createPostHandler,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(kAccentColor),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 20.0),
                        ),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      child: Text(
                        "Post",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
