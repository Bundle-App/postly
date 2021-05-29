import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'geolocation.freezed.dart';
part 'geolocation.g.dart';

@freezed
abstract class Geolocation with _$Geolocation {
  const Geolocation._();

  @JsonSerializable(explicitToJson: true)
  const factory Geolocation({
    @JsonKey(name: 'lat', defaultValue: '0.0') String latitude,
    @JsonKey(name: 'lng', defaultValue: '0.0') String longitude,
  }) = _Geolocation;

  factory Geolocation.fromJson(Map<String, dynamic> json) =>
      _$GeolocationFromJson(json);
}
