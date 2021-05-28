import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/username.dart';

part 'username_model.g.dart';

@JsonSerializable()
class UsernameModel extends Username {
  UsernameModel(username) : super(username);

  factory UsernameModel.fromJson(Map<String, dynamic> json) =>
      _$UsernameModelFromJson(json);

  late String username;

  Map<String, dynamic> toJson() => _$UsernameModelToJson(this);
}
