import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:postly/setUp.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await setUpLocator();
  runApp(Postly());
}

class Postly extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Postly',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Poppins",
        disabledColor: Colors.grey,
        cardColor: Colors.white,
        canvasColor: Colors.white,
        brightness: Brightness.light,
        buttonTheme: Theme.of(context).buttonTheme.copyWith(
              colorScheme: ColorScheme.light(),
            ),
        appBarTheme: AppBarTheme(
          elevation: 0.0,
        ),
      ),
      initialRoute: "/post",
      getPages: routes,
    );
  }
}
