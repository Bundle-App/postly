import 'package:Postly/bloc/postly_bloc.dart';
import 'package:Postly/views/create_post.dart';
import 'package:Postly/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(Postly());
}

class Postly extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostlyBloc>(
      create: (context) => PostlyBloc(null),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Postly',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: Home.id,
        routes: {
          Home.id: (context) => Home(),
          CreatePost.id: (context) => CreatePost(),
        },
      ),
    );
  }
}
