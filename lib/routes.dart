import 'package:get/get.dart';

import 'pages/pages.dart';

final routes = [
  GetPage(
    name: '/post',
    page: () => Profile(),
  ),
  GetPage(
    name: '/create_post',
    page: () => CreatePost(),
  ),
];
