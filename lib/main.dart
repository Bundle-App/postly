import 'package:Postly/locator.dart';
import 'package:Postly/models/address/address.dart';
import 'package:Postly/models/company/company.dart';
import 'package:Postly/models/geo/geo.dart';
import 'package:Postly/models/posts/post.dart';
import 'package:Postly/models/user/user.dart';
import 'package:Postly/utils/constants.dart';
import 'package:Postly/view_model/postly_view_model.dart';
import 'package:Postly/views/app_router.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as pp;

void main() async {
  await _openHive();
  await setUpLocator();
  runApp(Postly());
}

_openHive() async {
  WidgetsFlutterBinding.ensureInitialized();
  var appDocDir = await pp.getApplicationDocumentsDirectory();
  //Inotializing hive and registering adapter class of models saved locally
  Hive
    ..init(appDocDir.path)
    ..registerAdapter(UserAdapter())
    ..registerAdapter(AddressAdapter())
    ..registerAdapter(CompanyAdapter())
    ..registerAdapter(GeoAdapter())
    ..registerAdapter(PostAdapter());
}

class Postly extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PostlyViewModel>(
      create: (context) => PostlyViewModel(),
      child: MaterialApp(
        title: 'Postly',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: kBackground,
          appBarTheme: AppBarTheme(
            elevation: 0,
            color: kPrimaryColor,
          ),
          fontFamily: "Poppins-Regular",
        ),
        onGenerateRoute: _appRouter.onGenerateRoute,
      ),
    );
  }
}
