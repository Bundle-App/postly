import 'package:Postly/models/%20company.dart';
import 'package:Postly/models/address.dart';

class User {
  int id;
  String name;
  String username;
  String email;
  Address address;
  String phone;
  String website;
  Company company;
  User(
    this.id,
    this.name,
    this.username,
    this.email,
    this.phone,
    this.website,
  );
  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    phone = json['phone'];
    website = json['website'];
    company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
  }
}
