import 'package:json_annotation/json_annotation.dart';
import 'package:postly/features/user/domain/entities/posts.dart';

part 'posts_model.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class PostsModel extends Posts {
  PostsModel({required this.id, required this.body, required this.title})
      : super(id: id, body: body, title: title);

  factory PostsModel.fromJson(Map<String, dynamic> json) =>
      _$PostsModelFromJson(json);

  String title;

  String body;

  int id;

  Map<String, dynamic> toJson() => _$PostsModelToJson(this);
}
