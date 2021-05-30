import 'package:Postly/view_model/postly_view_model.dart';
import 'package:Postly/views/post_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class PostlyViewModelMock extends Mock implements PostlyViewModel {}

main() {
  Badge badge = Badge(level: 'Beginner', image: 'beginner');

  PostlyViewModelMock viewModel = PostlyViewModelMock();
  test("Testing function for badge", () {
    viewModel.setViewPoints(3);

    Widget testBadge = viewModel.badge();

    expect(testBadge, badge);
  });
}
