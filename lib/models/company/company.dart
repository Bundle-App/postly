

import 'package:hive/hive.dart';

part 'company.g.dart';

@HiveType(typeId: 2)
class Company {
  Company({
    this.name,
    this.catchPhrase,
    this.bs,
  });

  @HiveField(0)
  String name;

  @HiveField(1)
  String catchPhrase;

  @HiveField(2)
  String bs;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    name: json["name"],
    catchPhrase: json["catchPhrase"],
    bs: json["bs"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "catchPhrase": catchPhrase,
    "bs": bs,
  };
}
