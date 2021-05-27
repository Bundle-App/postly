import 'package:Postly/models/post.dart';

List<Post> userPostById(post, userId) {
  return post.where((post) => userId = post.id);
}
