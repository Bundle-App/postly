part of 'postly_bloc.dart';

@immutable
abstract class PostlyEvent extends Equatable {}

class GetUsers extends PostlyEvent {
  @override
  List<Object> get props => [];
}

class GetPosts extends PostlyEvent {
  @override
  List<Object> get props => [];
}

class CreatePost extends PostlyEvent {
  final Post post;
  CreatePost({this.post});

  @override
  List<Object> get props => [];
}
