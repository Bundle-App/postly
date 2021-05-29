class Post{
  int id;
  String title;
  String story;
  String date;

  Post({this.id, this.title, this.story, this.date});
}

List<Post> samplePosts = [
  Post(id:1,title: 'Alcantaraz',story: 'et iusto sed quo iure\nvoluptatem occaecati omnis eligendi aut ad\nvoluptatem doloribus vel accusantium quis pariatur\nmolestiae porro eius odio et labore et velit aut',date: '6th May, 21'),
  Post(id:2,title: 'Return to Oz',story: 'et iusto sed quo iure\nvoluptatem occaecati omnis eligendi aut ad\nvoluptatem doloribus',date: '6th May, 21'),
  Post(id:3,title: 'Stick with It',story: 'et iusto sed quo iure\nvoluptatem occaecati omnis eligendi aut ad\nvoluptatem doloribus vel accusantium quis pariatur\nmolestiae porro',date: '6th May, 21'),
  Post(id:4,title: 'Referral Bonus',story: 'et iusto sed quo iure\nvoluptatem occaecati omnis eligendi',date: '6th May, 21')
];