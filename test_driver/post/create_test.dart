import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Create post', () {
    late FlutterDriver driver;
    final now = DateTime.now().millisecondsSinceEpoch;
    final postBody = 'This is my post body-ody here: $now';

    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.waitUntilFirstFrameRasterized();
    });

    tearDownAll(() async {
      driver.close();
    });

    test('check Flutter driver health', () async {
      final health = await driver.checkHealth();
      expect(health.status, HealthStatus.ok);
    });

    test('Open create screen', () async {
      final postsFinder = find.byType("PostsScreen");
      await driver.waitFor(postsFinder);

      final fabFinder = find.byType("FloatingActionButton");
      await driver.waitFor(fabFinder);
      await driver.tap(fabFinder);
      await delay(1);

      final createScreen = find.byType("CreatePostScreen");
      await driver.waitFor(createScreen);
    });

    test('Enter title and body', () async {
      final titleFinder = find.byValueKey("title_field");
      await driver.waitFor(titleFinder);
      await driver.tap(titleFinder);
      await driver.enterText('This is my post title');

      await delay(1);

      final bodyFinder = find.byValueKey("body_field");
      await driver.waitFor(bodyFinder);
      await driver.tap(bodyFinder);
      await driver.enterText(postBody);
    });

    test('Create post', () async {
      await delay(2);

      final btnFinder = find.byValueKey("create_button");
      await driver.waitFor(btnFinder);
      await driver.tap(btnFinder);

      final postsFinder = find.byType("PostsScreen");
      await driver.waitFor(postsFinder);
    });

    test('Confirm listing of new post', () async {
      final newPostFinder = find.text(postBody);
      await driver.waitFor(newPostFinder);

      await delay(2);
    });
  });
}

Future<void> delay([int seconds = 1]) async {
  await Future<void>.delayed(Duration(seconds: seconds));
}
