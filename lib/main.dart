import 'dart:async';

import 'package:Postly/commons/env.dart';
import 'package:Postly/commons/providers.dart';
import 'package:Postly/commons/routes.dart';
import 'package:Postly/commons/strings.dart';
import 'package:Postly/screens/splash/splash.dart';
import 'package:Postly/services/auth/auth.dart';
import 'package:Postly/services/http/http.dart';
import 'package:Postly/services/post/post.dart';
import 'package:Postly/services/storage/post_storage.dart';
import 'package:Postly/services/storage/simple.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart' as path;
import 'package:logging/logging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Logger.root.level = EnvironmentConfig.getLogLevel();
  Logger.root.onRecord.listen((record) {
    debugPrint(
        '[${record.loggerName} | ${record.level.toString()}] - ${record.message}');
    if (record.level == Level.SEVERE) {
      //log severe errors to crash reporting tool
    }
  });

  final db = await _createSembastDB();

  runApp(MyApp(database: db));
}

class MyApp extends StatefulWidget {
  final Database database;

  const MyApp({
    Key? key,
    required this.database,
  }) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AuthService authService;
  late PostService postService;

  @override
  void initState() {
    super.initState();
    final httpService = HttpServiceImpl(
      'https://jsonplaceholder.typicode.com',
    );
    final simpleStorage = SecureStorageService(FlutterSecureStorage());
    final postStorageRef =
        stringMapStoreFactory.store(PostlyStrings.postStoreName);
    final postStorage = PostStorageServiceImpl(
      widget.database,
      postStorageRef,
    );
    authService = AuthServiceImpl(simpleStorage, httpService);
    postService = PostServiceImpl(postStorage, httpService);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: constructProviders(
        authService: authService,
        postService: postService,
      ),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.route,
        routes: routeTable,
      ),
    );
  }
}

Future<Database> _createSembastDB() async {
  final dbPath = 'postly.db';
  final dbFactory = databaseFactoryIo;
  final appDocDir = await getApplicationDocumentsDirectory();
  final db = await dbFactory.openDatabase(path.join(appDocDir.path, dbPath),
      version: 1);
  return db;
}
