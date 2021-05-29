import 'package:Postly/models/post/post.dart';
import 'package:Postly/states/post/post.dart';
import 'package:Postly/theme/colors.dart';
import 'package:Postly/widgets/field.dart';
import 'package:Postly/widgets/loader_stack.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatePostScreen extends StatefulWidget {
  static String route = '/posts/create';

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController;
  TextEditingController _bodyController;

  ValueNotifier<bool> _isCreating;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _bodyController = TextEditingController();

    _isCreating = ValueNotifier<bool>(false);
  }

  @override
  Widget build(BuildContext context) {
    final formTree = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              InputField(
                hint: 'Enter title',
                controller: _titleController,
                maxLength: 50,
                validator: (title) {
                  if (title.isEmpty) return 'Title cannot be left empty';

                  return null;
                },
                inputAction: TextInputAction.next,
              ),
              SizedBox(height: 20),
              InputField(
                hint: 'Enter post body',
                controller: _bodyController,
                maxLength: 100,
                maxLines: 10,
                validator: (title) {
                  if (title.isEmpty) return 'Post body cannot be left empty';

                  return null;
                },
                inputAction: TextInputAction.done,
              ),
              SizedBox(height: 100),
              MaterialButton(
                onPressed:_onCreate,
                color: PostlyColors.bundlePurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'CREATE POST',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Create Post',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: ValueListenableBuilder<bool>(
          valueListenable: _isCreating,
          builder: (context, showLoader, _) {
            return LoaderStack(child: formTree, showLoader: showLoader);
          }),
    );
  }

  void _onCreate() async {
    if (!_formKey.currentState.validate()) return;

    try {
      _isCreating.value = true;
      final postState = context.read<PostState>();
      final post = Post(
        id: DateTime.now().millisecondsSinceEpoch,
        title: _titleController.text,
        body: _bodyController.text,
        userId: 1,
      );
      await postState.createPost(post);
      Navigator.pop(context, true);

    } catch (e) {
      _isCreating.value = false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }
}
