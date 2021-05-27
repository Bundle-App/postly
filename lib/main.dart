import 'package:Postly/AppData.dart/appData.dart';
import 'package:Postly/AssistantRequest/assistantMethods.dart';
import 'package:Postly/constant/url.dart';
import 'package:Postly/widget/userpost.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Postly());
}

class Postly extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: PickedUser()),
        ChangeNotifierProvider.value(value: PostList())
      ],
      child: MaterialApp(
        title: 'Postly',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Posts'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _isLoading = false;
  var _isInit = true;

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

  @override
  Widget build(BuildContext context) {
    final name = Provider.of<PickedUser>(context, listen: false).selectedUser;
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
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'Welcome! $name',
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
                context: context, builder: (builder) => bottomSheet(context));
          },
          tooltip: 'Add post',
          child: Icon(Icons.add),
        ));
  }

  Widget bottomSheet(context) {
    return Container(
        height: 100.0,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          children: [
            Text('Create Post', style: TextStyle(fontSize: 20.0)),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                FlatButton.icon(
                    icon: Icon(Icons.camera),
                    onPressed: () {
                      // takePhoto(ImageSource.camera);
                    },
                    label: Text('Camera')),
                FlatButton.icon(
                    icon: Icon(Icons.image),
                    onPressed: () {
                      //takePhoto(ImageSource.gallery);
                    },
                    label: Text('Gallery'))
              ],
            )
          ],
        ));
  }
}
