import 'package:equatable/equatable.dart';
import 'package:postly/features/user/domain/entities/posts.dart';

abstract class PostsState extends Equatable {}

class PostsInitial extends PostsState {
  @override
  List<Object> get props => [];
}

class PostsLoading extends PostsState {
  @override
  List<Object> get props => [];
}

class PostsLoaded extends PostsState {
  PostsLoaded(this.posts);

  final List<Posts> posts;

  @override
  List<Object> get props => [posts];
}

class PostsError extends PostsState {
  PostsError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
