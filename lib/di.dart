import 'package:Postly/module/post/bloc/postly_bloc.dart';
import 'package:Postly/module/post/service/post_service.dart';
import 'package:get_it/get_it.dart';

// creating a singleton instance of getIt
var ioc = GetIt.instance;

void setupPostlyModuleService(GetIt ioc) {
  // Register Http service
  ioc.registerSingleton<PostService>(PostService());

  // Register bloc class
  ioc.registerSingleton<PostlyBloc>(PostlyBloc());
}
