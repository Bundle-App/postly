import 'package:Postly/models/post.dart';
import 'package:Postly/utils/constants.dart';
import 'package:Postly/view_model/postly_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<PostlyViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 120,
          title: Text('Post'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(100.0), // here the desired height
            child: Container(
              color: kBackground,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: kSubTextColor,
                      radius: 25,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('${vm.user.username}'),
                            SizedBox(
                              width: 5,
                            ),
                            CircleAvatar(
                              radius: 2.0,
                              backgroundColor: Colors.black,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('${vm.viewPoints.toString()}'),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_city,
                              size: 15,
                              color: kSubTextColor,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${vm.user.address.street}, ${vm.user.address.city}',
                              style:
                                  TextStyle(color: kSubTextColor, fontSize: 13),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    // Badge(),
                    vm.badge()
                  ],
                ),
              ),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/create_post');
                },
                icon: Icon(Icons.note_add_outlined))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: vm.posts.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    Post post = vm.posts[index];
                    return Card(
                      child: ListTile(
                        minLeadingWidth: 20,
                        leading: Icon(Icons.notes),
                        title: Text(post.title),
                        subtitle: Text(post.body),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }
}

class Badge extends StatelessWidget {
  final String level;
  final String image;

  Badge({@required this.level, @required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          level,
          style: TextStyle(color: kSubTextColor, fontSize: 13),
        ),
        Image.asset(
          'assets/images/$image.png',
          scale: 4,
        ),
      ],
    );
  }
}
