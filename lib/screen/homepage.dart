import 'package:Postly/cubit/badge_cubit.dart';
import 'package:Postly/cubit/posts_cubit.dart';
import 'package:Postly/model/user.dart';
import 'package:Postly/util/constants.dart';
import 'package:Postly/widget/custom_button.dart';
import 'package:Postly/widget/post_widget.dart';
import 'package:Postly/widget/postly_legend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:Postly/util/helper_functions.dart';

class Homepage extends StatefulWidget {
  final User user;

  const Homepage({Key key, this.user}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int selectedTab = 0;
  List<String> tabs = ['Posts', 'Mine'];

  void getSpecificPosts() {
    selectedTab == 0
        ? context.read<PostsCubit>().switchToAllPosts()
        : context.read<PostsCubit>().switchToLocalPosts();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PostsCubit>().retrieveAllPosts();
    context.read<BadgeCubit>().initBadge();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 0),
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
              BlocConsumer<BadgeCubit, BadgeState>(listener: (_, state) {
               if (state is BadgeProfessional && state.points>16 && state.initial ) {
                  showDialog(
                    context: context,
                    builder: (_) => Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 0,
                      child: PostlyLegend(),
                    ),
                  ).then((value){
                    context.read<BadgeCubit>().resetPoints();
                  });
               }
              }, builder: (_, state) {
                return Text(
                  state is BadgeBeginner
                      ? 'Beginner'
                      : state is BadgeIntermediate
                          ? 'Intermediate'
                          : state is BadgeProfessional
                              ? 'Expert'
                              : '',
                  style: TextStyle(
                      color: state is BadgeBeginner
                          ? AppColors.beginner
                          : state is BadgeIntermediate
                              ? AppColors.intermediate
                              : state is BadgeProfessional
                                  ? AppColors.professional
                                  : Colors.transparent,
                      fontSize: 11,
                      fontWeight: FontWeight.w300),
                );
              })
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
                getSpecificPosts();
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

  Widget _allPosts() =>
      BlocBuilder<PostsCubit, PostsState>(builder: (_, state) {
        return (state is PostsUnavailable && state.error != null)
            ? _errorWidget(context, state.error)
            : state is PostsRetrieved
                ? state.posts.isEmpty
                    ?  _emptyWidget(context)
                    : StaggeredGridView.countBuilder(
                        padding: EdgeInsets.only(bottom: 70),
                        physics: BouncingScrollPhysics(),
                        crossAxisCount: 4,
                        mainAxisSpacing: 9,
                        crossAxisSpacing: 9,
                        itemBuilder: (context, index) =>
                            PostWidget(post: state.posts[index]),
                        staggeredTileBuilder: (index) =>
                            const StaggeredTile.fit(2),
                        itemCount: state.posts.length,
                      )
                : _loader();
      });

  Widget _loader() => Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(AppColors.primary),
          strokeWidth: 1,
        ),
      );

  Widget _emptyWidget(context) => Center(
        child: Image.asset(
          'assets/png/empty.png',
          width: MediaQuery.of(context).size.width*.6,
        ),
      );

  Widget _errorWidget(BuildContext context, String error) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          MButton(
            text: 'Try again',
            image: 'assets/png/refresh.png',
            onClick: () {
              getSpecificPosts();
            },
            fillWidth: false,
          ),

        ],
      );

  Widget _createPost() => MButton(
      text: 'Write Something',
      image: 'assets/png/quill.png',
      onClick: () => Navigator.pushNamed(context, AppRoutes.createPost),
      fillWidth: false);
}
