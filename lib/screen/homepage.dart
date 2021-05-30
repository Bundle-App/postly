import 'package:Postly/cubit/badge_cubit.dart';
import 'package:Postly/cubit/posts_cubit.dart';
import 'package:Postly/model/post.dart';
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

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {

  AnimationController controller;
  Animation<Offset> firstSlideAnimation;
  Animation<Offset> secondSlideAnimation;

  int selectedTab = 0;
  List<String> tabs = ['Posts', 'Mine'];

  void getSpecificPosts() {
    selectedTab == 0
        ? context.read<PostsCubit>().switchToAllPosts()
        : context.read<PostsCubit>().switchToLocalPosts();
  }

  void changeTab(int tab) {
    setState(() {
      selectedTab = tab;
    });
    getSpecificPosts();
  }

  void setAnimation() {
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
    firstSlideAnimation =
        Tween<Offset>(begin: Offset(0.6, 0), end: Offset(0, 0)).animate(
            CurvedAnimation(
                parent: controller,
                curve: Interval(0.0, 0.6, curve: Curves.decelerate)));
    secondSlideAnimation =
        Tween<Offset>(begin: Offset(-0.4, 1), end: Offset(0, 0)).animate(
            CurvedAnimation(
                parent: controller,
                curve: Interval(0.25, 0.7, curve: Curves.decelerate)));
    controller.forward();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setAnimation();
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
              //header
              _header(),

              SizedBox(
                height: 40,
              ),

              //tabs
              _tabSelector(),

              SizedBox(
                height: 15,
              ),

              //post body
              Expanded(child: body())
            ],
          ),
        ),
      ),
      floatingActionButton: _createPost(),
    );
  }

  Widget _header() => SlideTransition(
        position: firstSlideAnimation,
        child: Row(
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
                  if (state is BadgeProfessional &&
                      state.points > 16 &&
                      state.initial) {
                    showDialog(
                      context: context,
                      builder: (_) => Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 0,
                        child: PostlyLegend(),
                      ),
                    ).then((value) {
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
                                ? 'Professional'
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
                        fontWeight: FontWeight.w400),
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
        ),
      );

  Widget _tabSelector() => SlideTransition(
        position: secondSlideAnimation,
        child: BlocBuilder<PostsCubit, PostsState>(builder: (context, state) {
          return Row(
            children: tabs.map((e) {
              bool isSelected = tabs.indexOf(e) == selectedTab;
              return Padding(
                padding: const EdgeInsets.only(right: 20, left: 5),
                child: GestureDetector(
                  onTap: state is PostsProcessing
                      ? () {}
                      : () => changeTab(tabs.indexOf(e)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                        height: 4,
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInCubic,
                        height: isSelected ? 4 : 0,
                        width: isSelected ? 15 : 0,
                        decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(7)),
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        }),
      );

  Widget body() => BlocBuilder<PostsCubit, PostsState>(builder: (_, state) {
        return (state is PostsUnavailable && state.error != null)
            ? _errorWidget(context, state.error)
            : state is PostsRetrieved
                ? state.posts.isEmpty
                    ? _emptyWidget(context)
                    : _postsWidget(context, state.posts)
                : _loader();
      });


  Widget _postsWidget(context, List<Post> posts) => TweenAnimationBuilder(
      tween: Tween<double>(
        begin: .2,
        end: 1,
      ),
      duration: Duration(milliseconds: 600),
      curve: Curves.easeInOutCirc,
      builder: (context, val, child) {
        return Opacity(
          opacity: val,
          child: StaggeredGridView.countBuilder(
            padding: EdgeInsets.only(bottom: 70),
            physics: BouncingScrollPhysics(),
            crossAxisCount: 4,
            mainAxisSpacing: 9,
            crossAxisSpacing: 9,
            itemBuilder: (context, index) => PostWidget(post: posts[index]),
            staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
            itemCount: posts.length,
          ),
        );
      });

  Widget _loader() => Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(AppColors.primary),
          strokeWidth: 1.5,
        ),
      );

  Widget _emptyWidget(context) => Center(
        child: Image.asset(
          'assets/png/empty.png',
          width: MediaQuery.of(context).size.width * .6,
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
              context.read<PostsCubit>().retrieveAllPosts();
            },
            fillWidth: false,
          ),
        ],
      );

  Widget _createPost() => TweenAnimationBuilder(
      tween: Tween<Offset>(begin: Offset(.7, 1), end: Offset(0, 0)),
      duration: Duration(milliseconds: 1000),
      curve: Curves.decelerate,
      builder: (context, val, child) {
        return SlideTransition(
          position: AlwaysStoppedAnimation(val),
          child: MButton(
              text: 'Write Something',
              image: 'assets/png/quill.png',
              onClick: () => Navigator.pushNamed(context, AppRoutes.createPost),
              fillWidth: false),
        );
      });
}
