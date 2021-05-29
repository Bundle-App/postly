import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'post.freezed.dart';
part 'post.g.dart';

@freezed
abstract class Post with _$Post {
  const Post._();

  @JsonSerializable(explicitToJson: true)
  const factory Post({
    @JsonKey(name: 'userId') num userId,
    @JsonKey(name: 'id') num id,
    @JsonKey(name: 'title', defaultValue: '') String title,
    @JsonKey(name: 'body', defaultValue: '') String body,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
