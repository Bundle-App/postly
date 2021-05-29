import 'package:Postly/cubit/user_cubit.dart';
import 'package:Postly/model/post.dart';
import 'package:Postly/model/user.dart';
import 'package:Postly/util/constants.dart';
import 'package:Postly/widget/custom_button.dart';
import 'package:Postly/widget/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Homepage extends StatefulWidget {
  final User user;

  const Homepage({Key key, this.user}) : super(key: key);
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int selectedTab = 0;
  List<String> tabs = ['Posts', 'Mine'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              _header(),
              SizedBox(
                height: 40,
              ),
              _tabSelector(),
              SizedBox(
                height: 15,
              ),
              Expanded(child: _allPosts())
            ],
          ),
        ),
      ),
      floatingActionButton: _createPost(),
    );
  }

  Widget _header() => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.primary,
            child: Text(
              '${widget.user.username.firstCharacter()}',
              style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${widget.user.username.toInitialCaps()}',
                style: TextStyle(
                    color: AppColors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                'Beginner',
                style: TextStyle(
                    color: AppColors.beginner,
                    fontSize: 11,
                    fontWeight: FontWeight.w300),
              )
            ],
          ),
          Spacer(),
          Image.asset(
            'assets/png/bell.png',
            color: AppColors.black,
            height: 18,
          )
        ],
      );

  Widget _tabSelector() => Row(
        children: tabs.map((e) {
          bool isSelected = tabs.indexOf(e) == selectedTab;
          return Padding(
            padding: const EdgeInsets.only(right: 20, left: 5),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedTab = tabs.indexOf(e);
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    e,
                    style: TextStyle(
                        color: isSelected
                            ? AppColors.black
                            : AppColors.grey.withOpacity(.7),
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  AnimatedOpacity(
                    opacity: isSelected ? 1 : 0,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInCubic,
                    child: CircleAvatar(
                      backgroundColor: AppColors.primary,
                      radius: 3,
                    ),
                  )
                ],
              ),
            ),
          );
        }).toList(),
      );

  Widget _allPosts() => StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        mainAxisSpacing: 9,
        crossAxisSpacing: 9,
        itemBuilder: (context, index) => PostWidget(post: samplePosts[index]),
        staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
        itemCount: samplePosts.length,
      );

  Widget _createPost() => MButton(
      text: 'Say Something',
      image: 'assets/png/quill.png',
      onClick: () => Navigator.pushNamed(context, AppRoutes.createPost),
      fillWidth: false);
}
