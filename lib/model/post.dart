import 'package:equatable/equatable.dart';

class Post extends Equatable{
  int id;
  String title;
  String body;

  Post({this.id, this.title, this.body,});

  factory Post.fromMap(Map<String, dynamic> data) => Post(
        id: data['id'],
        title: data['title'],
        body: data['body'],
      );

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'title': this.title,
        'body': this.body,
      };

  @override
  // TODO: implement props
  List<Object> get props => [id,title,body];
}

