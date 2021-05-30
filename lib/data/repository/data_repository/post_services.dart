import 'package:Postly/data/data_provider/api_client.dart';
import 'package:Postly/models/posts/post.dart';

import '../../../locator.dart';

class PostServices {
  var _apiClient = locator<ApiClient>();

  Future<List<Post>> getPosts() async {
    try {
      final data = await _apiClient.get("posts");
      var posts = (data as List).map((e) => Post.fromJson(e)).toList();
      return posts;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
