import 'package:Postly/models/geo/geo.dart';
import 'package:hive/hive.dart';
part 'address.g.dart';

@HiveType(typeId: 1)
class Address {
  Address({
    this.street,
    this.suite,
    this.city,
    this.zipcode,
    this.geo,
  });

  @HiveField(0)
  String street;

  @HiveField(1)
  String suite;

  @HiveField(2)
  String city;

  @HiveField(3)
  String zipcode;

  @HiveField(4)
  Geo geo;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        street: json["street"],
        suite: json["suite"],
        city: json["city"],
        zipcode: json["zipcode"],
        geo: Geo.fromJson(json["geo"]),
      );

  Map<String, dynamic> toJson() => {
        "street": street,
        "suite": suite,
        "city": city,
        "zipcode": zipcode,
        "geo": geo.toJson(),
      };
}
