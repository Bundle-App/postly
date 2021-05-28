import 'package:Postly/AppData.dart/appData.dart';
import 'package:Postly/AssistantRequest/assistantMethods.dart';
import 'package:Postly/constant/url.dart';
import 'package:Postly/screens/connection.dart';
import 'package:Postly/services/storage.dart';
import 'package:Postly/util/button.dart';
import 'package:Postly/util/font.dart';
import 'package:Postly/util/text_form.dart';
import 'package:Postly/util/validator.dart';
import 'package:Postly/widget/badge.dart';
import 'package:Postly/widget/userpost.dart';
import 'package:connectivity/connectivity.dart';
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
          content: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
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
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        ' $name ',
                        style: TextStyle(fontSize: 20.0),
                      )),
                  if (_points < 6)
                    Badge('Beginner')
                  else if (_points >= 6 && _points < 10)
                    Badge('Intermediate')
                  else if (_points >= 10 && _points <= 16)
                    Badge('Professional')
                  else
                    Badge('Postly Legend'),
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        '$_points points',
                        style: TextStyle(fontSize: 20.0),
                      )),
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
                enableDrag: true,
                context: context,
                builder: (builder) => bottomSheet(context));
          },
          tooltip: 'Add post',
          child: Icon(Icons.add),
        ));
  }

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
                //Icon(Icons.keyboard_arrow_left),
                Text('Create Post', style: TextStyle(fontSize: 20.0)),
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
              validator: TitleValidator.validate,
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
              validator: TitleValidator.validate,
              onSaved: (val) {
                messageController = val;
              },
              maxline: 5,
            ),
          ],
        ));
  }
}
