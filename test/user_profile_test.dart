import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:postly/controllers/user.dart';
import 'package:postly/enums/app_state.dart';

import 'mocks/mocks.dart';

void main() {
  setUp(() {
    Get.testMode = true;
  });
  group('Init', () {
    setUp(() => registerServices());
    tearDown(() => unregisterServices());
    test('initialized app', () async {
      var controller = UserController();
      expect(controller.appState == AppState.loading, true);
      expect(controller.user == null, true);
      expect(controller.posts == null, true);
    });

    test("App can get user and posts", () async {
      var userServices = getAndRegisterUserServiceMock();
      var postServices = getAndRegisterPostServiceMock();

      var controller = UserController();
      await controller.getData();
      verify(userServices.getUsers());
      verify(postServices.getPost());

      /// Check loading state
      expect(controller.appState == AppState.none, true);

      /// Check if post is greater than 1
      expect(controller.posts.length > 1, true);

      /// Check if user is not null
      expect(controller.user != null, true);
    });
  });
}
