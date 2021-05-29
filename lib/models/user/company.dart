import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'company.freezed.dart';
part 'company.g.dart';

@freezed
abstract class Company with _$Company {
  const Company._();

  @JsonSerializable(explicitToJson: true)
  const factory Company({
    @JsonKey(name: 'name', defaultValue: '') String name,
    @JsonKey(name: 'catchPhrase', defaultValue: '') String catchPhrase,
    @JsonKey(name: 'bs', defaultValue: '') String bs,
  }) = _Company;

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

}
