import 'dart:async';
import 'package:Postly/models/post/post.dart';
import 'package:logging/logging.dart';
import 'package:sembast/sembast.dart';

const String postStoreName = '_post_store_v1';

abstract class PostStorageService {
  FutureOr<void> storeCreatedPost(Post post);
  Future<List<Post>> getCreatedPosts();
  FutureOr<bool> dropPostStore();
}

class PostStorageServiceImpl implements PostStorageService {
  Database db;
  StoreRef _postStore;
  bool hasTimestamp;

  final timeStampKey = 'timestamp';

  PostStorageServiceImpl(this.db) {
    _postStore = stringMapStoreFactory.store(postStoreName);
  }

  final _log = Logger('PostStorageServiceImpl');

  @override
  FutureOr<void> storeCreatedPost(Post post) async {
    await _postStore.record(post.id).put(
          db,
          post.toJson(),
          merge: true,
        );
  }

  @override
  Future<List<Post>> getCreatedPosts() async {
    final records = await _postStore.find(db);
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
      await _postStore.drop(db);
      return true;
    } catch (e, t) {
      _log.severe('Error in dropPostStore: $e, \nStackTrace: $t');
      return false;
    }
  }
}
