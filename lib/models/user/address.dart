import 'package:Postly/models/user/geolocation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'address.freezed.dart';
part 'address.g.dart';

@freezed
abstract class Address with _$Address {
  const Address._();

  @JsonSerializable(explicitToJson: true)
  const factory Address({
    @JsonKey(name: 'street', defaultValue: '') String street,
    @JsonKey(name: 'suite', defaultValue: '') String suite,
    @JsonKey(name: 'city', defaultValue: '') String city,
    @JsonKey(name: 'zipcode', defaultValue: '') String zipcode,
    @JsonKey(name: 'geo') Geolocation geolocation,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}
