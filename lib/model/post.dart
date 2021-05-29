class Post {
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
}

