import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class UserModel extends User {
  UserModel({required this.username}) : super(username: username);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  // ignore: annotate_overrides
  String username;

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
