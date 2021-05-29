import 'dart:convert';

import 'package:Postly/models/user/address.dart';
import 'package:Postly/models/user/company.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  const User._();

  @JsonSerializable(explicitToJson: true)
  const factory User({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'username', defaultValue: '') String username,
    @JsonKey(name: 'name', defaultValue: '') String name,
    @JsonKey(name: 'email', defaultValue: '') String email,
    @JsonKey(name: 'address') Address address,
    @JsonKey(name: 'phone', defaultValue: '') String phone,
    @JsonKey(name: 'website', defaultValue: '') String website,
    @JsonKey(name: 'company') Company company,
    @Default(0) int points,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  bool get hasCompany => company != null;

  bool get hasAddress => address != null;

  bool get isBeginner {
    return true;
  }

  bool get isIntermediate {
    return true;
  }

  bool get isProfessional {
    return true;
  }

  bool get isLegend {
    return true;
  }
}
