import 'package:Postly/cubit/badge_cubit.dart';
import 'package:Postly/cubit/posts_cubit.dart';
import 'package:Postly/cubit/user_cubit.dart';
import 'package:Postly/repo/badge_repo.dart';
import 'package:Postly/repo/post_repo.dart';
import 'package:Postly/repo/user_repo.dart';
import 'package:Postly/routes.dart';
import 'package:Postly/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {

  BadgeCubit badgeCubit = BadgeCubit(BadgeRepo());
  runApp(MultiBlocProvider(providers: [
    BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(UserRepo()),
    ),
    BlocProvider<BadgeCubit>(
      create: (BuildContext context) => badgeCubit,
    ),
    BlocProvider<PostsCubit>(
      create: (BuildContext context) => PostsCubit(PostRepo(),badgeCubit),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Postly',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        accentColor: AppColors.primary,
        fontFamily: 'Quicksand',
        // scaffoldBackgroundColor: AppColors.white
      ),
      onGenerateRoute: Routes.getRoute,
    );
  }
}
