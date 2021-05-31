import 'package:Postly/configs/app_config.dart';
import 'package:Postly/di.dart';
import 'package:Postly/module/onboarding/root.dart';
import 'package:Postly/module/post/model/post/post.dart';
import 'package:Postly/module/post/model/user/user.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupPostlyModuleService(ioc);
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(AddressAdapter());
  Hive.registerAdapter(GeoAdapter());
  Hive.registerAdapter(CompanyAdapter());
  Hive.registerAdapter(PostAdapter());

  await Hive.openBox<User>(AppConfig.userBoxName);
  await Hive.openBox<Post>(AppConfig.postBoxName);
  runApp(Postly());
}

class Postly extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Postly',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Onboarding(),
    );
  }
}
