import 'dart:async';

import 'package:Postly/screens/allPost.dart';
import 'package:Postly/screens/connection.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

//this screen checks if there is a network connection or not
class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  bool isConnected = false;
  StreamSubscription sub;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sub = Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        isConnected = (result != ConnectivityResult.none);
      });
      print(isConnected);
    });
  }

  @override
  void dispose() {
    sub.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: isConnected ? MyHomePage(title: 'postly') : Connection()));
  }
}
