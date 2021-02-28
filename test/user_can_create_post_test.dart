import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:postly/controllers/post.dart';

void main() {
  setUp(() {
    Get.testMode = true;
  });
  group('Test post is created', () {
    test('When post is created', () async {
      var controller = PostController();
      await controller.createPost("lekan", "Ogun gbgemi");
      expect(controller.isSubmitted == true, true);
    });
  });
}
