import 'package:equatable/equatable.dart';

class User extends Equatable{
  int id;
  String name;
  String username;
  String email;

  User({this.id, this.name, this.username, this.email});

  factory User.fromMap(Map<String, dynamic> data) => User(
      id: data['id'],
      name: data['name'],
      username: data['username'],
      email: data['email']);

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'name': this.name,
        'username': this.username,
        'email': this.email
      };

  @override
  // TODO: implement props
  List<Object> get props =>[this.id,this.name,this.email,this.username];
}
