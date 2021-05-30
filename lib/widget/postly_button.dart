import 'package:Postly/utils/constants.dart';
import 'package:Postly/utils/responsiveness.dart';
import 'package:Postly/view_model/postly_view_model.dart';
import 'package:flutter/material.dart';

class PostlyButton extends StatelessWidget {
  const PostlyButton({
    Key key,
    this.viewModel,
    this.postController,
    this.titleController,
    @required this.onPressed,
    @required this.child,
  }) : super(key: key);

  final PostlyViewModel viewModel;
  final TextEditingController postController;
  final TextEditingController titleController;
  final Function onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: screenWidth(context),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: child,
      ),
    );
  }
}
