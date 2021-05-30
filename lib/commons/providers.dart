import 'package:Postly/services/auth/auth.dart';
import 'package:Postly/services/post/post.dart';
import 'package:Postly/states/auth/auth.dart';
import 'package:Postly/states/post/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> constructProviders({
  required AuthService authService,
  required PostService postService,
}) {
  return <SingleChildWidget>[
    ChangeNotifierProvider<AuthState>(create: (_) => AuthState(authService)),
    ChangeNotifierProxyProvider<AuthState, PostState>(
      create: (context) => PostState(postService),
      update: (context, authState, postState) {
        if (postState == null) return PostState(postService);

        return postState..authState = authState;
      },
    ),
  ];
}
