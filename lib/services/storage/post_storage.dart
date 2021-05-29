import 'dart:async';
import 'package:Postly/commons/strings.dart';
import 'package:Postly/models/post/post.dart';
import 'package:logging/logging.dart';
import 'package:sembast/sembast.dart';

abstract class PostStorageService {
  FutureOr<void> storeCreatedPost(Post post);
  Future<List<Post>> getCreatedPosts();
  FutureOr<bool> dropPostStore();
}

class PostStorageServiceImpl implements PostStorageService {
  final Database db;
  final StoreRef postStore;

  PostStorageServiceImpl(this.db, this.postStore);

  final _log = Logger('PostStorageServiceImpl');

  @override
  FutureOr<void> storeCreatedPost(Post post) async {
    await postStore.record(post.id.toString()).put(
          db,
          post.toJson(),
          merge: true,
        );
  }

  @override
  Future<List<Post>> getCreatedPosts() async {
    final records = await postStore.find(db);
    final postsList = <Post>[];

    records.forEach((record) {
      postsList.add(
        Post.fromJson(
          Map<String, dynamic>.from(record.value),
        ),
      );
    });

    return postsList;
  }

  @override
  FutureOr<bool> dropPostStore() async {
    try {
      await postStore.drop(db);
      return true;
    } catch (e, t) {
      _log.severe('Error in dropPostStore: $e, \nStackTrace: $t');
      return false;
    }
  }
}
