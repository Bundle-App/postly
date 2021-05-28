import 'package:hive/hive.dart';

part 'geo.g.dart';

@HiveType(typeId: 3)
class Geo {
  Geo({
    this.lat,
    this.lng,
  });

  @HiveField(0)
  String lat;

  @HiveField(1)
  String lng;

  factory Geo.fromJson(Map<String, dynamic> json) => Geo(
        lat: json["lat"],
        lng: json["lng"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}
