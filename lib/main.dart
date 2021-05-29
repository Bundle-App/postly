import 'package:Postly/AppData.dart/appData.dart';
import 'package:Postly/screens/first_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Postly());
}

class Postly extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: PickedUser()),
          ChangeNotifierProvider.value(value: PostList())
        ],
        child: MaterialApp(
            title: 'Postly',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: FirstScreen()));
  }
}
