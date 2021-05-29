import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postly/core/error/failure.dart';
import 'package:postly/features/user/domain/usecases/get_posts.dart';
import 'package:postly/features/user/presentation/notifiers/posts_state.dart';
import '../../../../core/usecases/usecase.dart';

class PostsNotifier extends StateNotifier<PostsState> {
  PostsNotifier(this.allPosts) : super(PostsInitial());

  final GetPosts allPosts;

  void fetchPosts() async {
    state = PostsLoading();
    final result = await allPosts(NoParams());
    result.fold(
      (failure) => state = PostsError(mapFailureToMessage(failure)),
      (result) => state = PostsLoaded(result),
    );
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
}
