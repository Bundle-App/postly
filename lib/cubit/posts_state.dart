part of 'posts_cubit.dart';

abstract class PostsState extends Equatable {
  const PostsState();
}

class PostsUnavailable extends PostsState{
final String error;

  PostsUnavailable({this.error});
  @override
  List<Object> get props => [error];
}

class PostsProcessing extends PostsState {
  @override
  List<Object> get props => [];
}

class PostsRetrieved extends PostsState {
  final List<Post> posts;

  PostsRetrieved(this.posts);
  @override
  List<Object> get props => [posts];
}

