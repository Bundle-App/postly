import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'dart:math';

class PostController extends GetxController {
  var rng = new Random();
  var isSubmitted = false;

  createPost(title, body) {
    Map<String, dynamic> data = {
      "userId": rng.nextInt(100),
      "id": rng.nextInt(100),
      "title": title,
      "body": body,
    };
    isSubmitted = true;
    Get.back(result: data);
  }
}
