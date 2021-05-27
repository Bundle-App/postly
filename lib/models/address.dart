import 'package:Postly/models/geo.dart';

class Address {
  String street;
  String suite;
  String city;
  String zipcode;
  Geo geo;
  Address(
    this.street,
    this.suite,
    this.city,
    this.zipcode,
  );

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    suite = json['suite'];
    city = json['city'];
    zipcode = json['zipcode'];
    geo = json['geo'] != null ? Geo.fromJson(json['geo']) : null;
  }
}
