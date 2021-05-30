import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postly/core/utils/field_validator.dart';
// import 'package:postly/features/user/domain/entities/posts.dart';
// import 'package:postly/features/user/presentation/notifiers/posts_state.dart';

import 'home.dart';

class CreatePost extends ConsumerWidget {
  CreatePost({Key? key}) : super(key: key);
  final TextEditingController _title = TextEditingController();
  final TextEditingController _body = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // var count = watch(postsProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Post'),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _title,
                  decoration:
                      textMaxInputDecoration.copyWith(hintText: 'Enter Title'),
                  validator: FieldValidator.validateText,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _body,
                  maxLines: 10,
                  decoration:
                      textMaxInputDecoration.copyWith(hintText: 'Enter Body'),
                  validator: FieldValidator.validateText,
                ),
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read(pointsNotifier.notifier).increment();

                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Message'),
                              content: const Text('Post created!'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    var count = 0;
                                    Navigator.popUntil(context, (route) {
                                      return count++ == 2;
                                    });
                                  },
                                  child: const Text(
                                    'OK',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            );
                          });
                    }
                    // if (count is PostsLoaded) {
                    //   count.posts.insert(
                    //     1,
                    //     const Posts(title: 'test', body: 'body'),
                    //   );
                    // }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Create Post',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const textMaxInputDecoration = InputDecoration(
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  ),
  errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
  focusedErrorBorder:
      OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
  fillColor: Colors.white,
  filled: true,
);
