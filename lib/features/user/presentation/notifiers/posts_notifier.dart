import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postly/core/error/failure.dart';
import 'package:postly/features/user/domain/entities/posts.dart';
import 'package:postly/features/user/domain/usecases/get_posts.dart';
import 'package:postly/features/user/presentation/notifiers/posts_state.dart';
import '../../../../core/usecases/usecase.dart';

// class CreatePost extends StateNotifier<Posts>{

// }
class PostsNotifier extends StateNotifier<PostsState> {
  PostsNotifier(this.getAllPosts) : super(PostsInitial());

  final GetPosts getAllPosts;

  void fetchPosts() async {
    state = PostsLoading();
    final result = await getAllPosts(NoParams());

    result.fold(
      (failure) => state = PostsError(mapFailureToMessage(failure)),
      (result) => state = PostsLoaded(result),
    );
  }

  dynamic createPost(List<Posts> result) async {
    state = PostsLoaded(result);
    return result;
  }
}

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return 'No Posts found';
    case CacheFailure:
      return 'No internet connection';
    default:
      return 'Unexpected error';
  }
}
