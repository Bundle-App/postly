import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  const User._();

  @JsonSerializable(explicitToJson: true)
  const factory User({
    @JsonKey(name: 'id', defaultValue: -1) required int id,
    @JsonKey(name: 'username', defaultValue: '') required String username,
    @Default(0) int points,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  bool get isBeginner {
    return points < 6;
  }

  bool get isIntermediate {
    return points >= 6 && points < 10;
  }

  bool get isProfessional {
    return points >= 10 && points <= 16;
  }

  bool get isLegend {
    return points > 16;
  }

  String get badge {
    if (isBeginner) return 'Beginner';

    if (isIntermediate) return 'Intermediate';

    if (isProfessional) return 'Professional';

    return 'Legend';
  }

  Color get badgeColor {
    if (isBeginner) return Colors.red;

    if (isIntermediate) return Colors.yellow;

    if (isProfessional) return Colors.blue;

    return Colors.green;
  }
}
