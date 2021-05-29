import 'package:Postly/AppData.dart/appData.dart';
import 'package:Postly/AssistantRequest/assistantMethods.dart';
import 'package:Postly/constant/url.dart';

import 'package:Postly/services/storage.dart';
import 'package:Postly/util/button.dart';
import 'package:Postly/util/font.dart';
import 'package:Postly/util/metrics.dart';
import 'package:Postly/util/text_form.dart';
import 'package:Postly/util/validator.dart';
import 'package:Postly/widget/badge.dart';
import 'package:Postly/widget/userpost.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  //static const routeName = 'home';
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  var _isLoading = false;
  var _isInit = true;
  String titleController;
  String messageController;
  int _points;
  final BadgeMetric badge = new BadgeMetric();

  @override
  void initState() {
    _checkScoredPoints();
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      AssistantMethods.getUsersList(url, context).then((_) async {
        await AssistantMethods.getPost(post, context);

        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

//method to notify the listener that a new post has been added making use of provider for state management
  void addPost() async {
    var form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      Provider.of<PostList>(context, listen: false)
          .addNewPost(titleController, messageController);
      setState(() {
        _points = _points + 2;
      });
      await UserData.setPoints(_points); //store point locally
      Navigator.pop(context);
    }
  }

//method to display you are a postly legend if points greater than 16 and also fetches local stored points
  _checkScoredPoints() async {
    var _point = await UserData.getPoint();
    setState(() {
      _points = _point;
    });
    print('point:$_points');
    if (_points > 16) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: Color(0xffbbdefb),
          content: Container(
            child: Text("You are a postly legend"),
          ),
        ),
      ).then(
        (value) async {
          setState(() {
            _points = 0;
          });
          await UserData.setPoints(_points); //set point locally
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final name = Provider.of<PickedUser>(context).selectedUser;
    final userPost = Provider.of<PostList>(context).post;
    return Scaffold(
        backgroundColor: Color(0xffbbdefb),
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ' $name ',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        CircleAvatar(
                          radius: 15.0,
                          child: Text(
                            '$_points',
                            style: TextStyle(fontSize: 13.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Badge(badge.badge(_points)),
                  Expanded(
                    child: ListView.builder(
                        itemCount: userPost.length,
                        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                            value: userPost[i], child: UserPost())),
                  )
                ],
              ), // This trailing comma makes auto-formatting nicer for build methods.
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Color(0xffbbdefb),
                enableDrag: true,
                context: context,
                builder: (builder) => bottomSheet(context));
          },
          tooltip: 'Add post',
          child: Icon(Icons.add),
        ));
  }

//Bottom sheet for the form
  Widget bottomSheet(context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackButton(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Create Post', style: TextStyle(fontSize: 20.0)),
                ),
                Text(
                  '',
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 7,
              child: ListView(
                children: [Form(key: _formKey, child: formField())],
              ),
            ),
            SizedBox(height: 10.0),
            CustomButton(
              onPress: () {
                addPost();
              },
              btnText: 'Post',
              txtColor: Colors.white,
            ),
          ],
        ));
  }

//entry text form field for posting
  Widget formField() {
    return Container(
        height: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title',
              style: notoSansTextStyle(16.0, 0xff222222, FontWeight.w600),
            ),
            SizedBox(height: 10.0),
            TextFieldContainer(
              obscure: false,
              textInputType: TextInputType.text,
              validator: FormValidator.validate,
              onSaved: (val) {
                titleController = val;
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Message',
              style: notoSansTextStyle(16.0, 0xff222222, FontWeight.w600),
            ),
            SizedBox(height: 10.0),
            TextFieldContainer(
              obscure: false,
              textInputType: TextInputType.text,
              validator: FormValidator.validate,
              onSaved: (val) {
                messageController = val;
              },
              maxline: 5,
            ),
          ],
        ));
  }
}
