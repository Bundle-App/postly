part of 'postly_bloc.dart';

@immutable
abstract class PostlyState extends Equatable {}

class PostInitial extends PostlyState {
  @override
  List<Object> get props => [];
}

// [FetchingUsers] is a loading state when it's currently fetching user's from the server
class FetchingUsers extends PostlyState {
  @override
  List<Object> get props => [];
}

// [FetchedUsers] is a loading state that got triggered when user's data has been successfully fetched
class FetchedUser extends PostlyState {
  @override
  List<Object> get props => [];
}

// [FetchedUsersWithError] is a Error state that got triggered when the network request was not successful
class FetchedUsersWithError extends PostlyState {
  final String message;
  FetchedUsersWithError({this.message});

  @override
  List<Object> get props => [message];
}

// [FetchingPosts] is a loading state that emit when it's currently fetching post's from the server
class FetchingPosts extends PostlyState {
  @override
  List<Object> get props => [];
}

// [FetchedPosts] is a loading state that got triggered when user's data has been successfully fetched
class FetchedPosts extends PostlyState {
  final List<Post> posts;
  FetchedPosts({this.posts});

  @override
  List<Object> get props => [posts];
}

// [FetchedPostsWithError] is a Error state that got triggered when the network request was not successful
class FetchedPostsWithError extends PostlyState {
  final String message;
  FetchedPostsWithError({this.message});

  @override
  List<Object> get props => [message];
}

class CreatingPost extends PostlyState {
  @override
  List<Object> get props => [];
}

// [FetchedPosts] is a loading state that got triggered when user's data has been successfully fetched
class CreatedPost extends PostlyState {
  @override
  List<Object> get props => [];
}

// [FetchedPostsWithError] is a Error state that got triggered when the network request was not successful
class CreatePostWithError extends PostlyState {
  final String message;
  CreatePostWithError({this.message});

  @override
  List<Object> get props => [message];
}