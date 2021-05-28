import 'package:Postly/AppData.dart/appData.dart';

import 'package:Postly/screens/allPost.dart';
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
          home: MyHomePage(
            title: 'Posts',
          )),
    );
  }
}
