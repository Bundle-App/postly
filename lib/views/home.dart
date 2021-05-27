import 'dart:convert';

import 'package:Postly/bloc/postly_bloc.dart';
import 'package:Postly/enums/home_state.dart';
import 'package:Postly/events/postly_events.dart';
import 'package:Postly/model/post.dart';
import 'package:Postly/model/user.dart';
import 'package:Postly/states/postly_states.dart';
import 'package:Postly/utils/colors.dart';
import 'package:Postly/utils/custom_function.dart';
import 'package:Postly/utils/styles.dart';
import 'package:Postly/views/create_post.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  static String id = 'home';

  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeState _homeState = HomeState.LOADING;

  final customFunction = CustomFunction();

  User _user;
  List<Post> _posts = [];
  String _errorMessage;

  bool _isScrolling = false;

  /// This method handles adding the bloc event responsible for navigating to the
  /// create post widget
  void floatingButtonClickHandler() {
    BlocProvider.of<PostlyBloc>(context).add(NavigateToCreatePostEvent());
  }

  /// This method handles updating the user's point tally and saving it locally
  /// in the device using SharedPreferences
  void updateUserPointLocally() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String encodedUserData = jsonEncode(_user);

    sharedPreferences.setString("storedUser", encodedUserData);
  }

  /// This method handles showing a dialog to the user and is only called on first
  /// launch if the user has a point greater that "16"
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text(
            "You are a postly legend",
            style: kAppBarStyle.copyWith(color: kAccentColor, fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Dismiss',
                style: kTextStyleSemiBold15,
              ),
              onPressed: () {
                setState(() {
                  _user.points = 0;
                });

                updateUserPointLocally();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /// This method is responsible for showing the badge metric title based on the
  /// user's acquired points
  Widget badgeMetric(int points) {
    Widget badgeTitle;

    String metrics = customFunction.badgeMetric(points);

    if (points < 6) {
      badgeTitle = Text(
        metrics,
        style: kTextStyleRegular15,
      );
    } else if (points < 10) {
      badgeTitle = Text(
        metrics,
        style: kTextStyleSemiBold15,
      );
    } else {
      badgeTitle = Text(
        metrics,
        style: kTextStyleBold15.copyWith(color: kCatchyColor),
      );
    }

    return badgeTitle;
  }

  /// Widget method that outputs the appropriate widget depending on the
  /// [HomeState] enum values
  Widget widgetToDisplay(HomeState state) {
    Widget displayWidget;
    if (state == HomeState.LOADING) {
      displayWidget = Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.blue,
        ),
      );
    }

    if (state == HomeState.LOADED) {
      displayWidget = Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4.0,
              color: kSecondaryColor,
              margin: const EdgeInsets.only(bottom: 16.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 28.0,
                      backgroundColor: Color(0xff210A54),
                      child: Icon(
                        Icons.person,
                        size: 40.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      "@${_user.username}",
                      style: kTextStyleRegular15.copyWith(
                          fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Badge(
                      position: BadgePosition(
                        end: -24.0,
                        top: -8.0,
                      ),
                      badgeColor: Color(0xffFFD700),
                      badgeContent: Text(
                        _user.points.toString(),
                        style: kTextStyleRegular15.copyWith(fontSize: 12.0),
                      ),
                      child: Text(
                        _user.name,
                        style: kTextStyleSemiBold15,
                      ),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    badgeMetric(_user.points),
                  ],
                ),
              ),
            ),
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollStartNotification) {
                    if (!_isScrolling) {
                      setState(() => _isScrolling = true);
                    }
                  } else if (scrollNotification is ScrollEndNotification) {
                    if (_isScrolling) {
                      setState(() => _isScrolling = false);
                    }
                  }
                  return false;
                },
                child: ListView.builder(
                    itemCount: _posts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        margin: EdgeInsets.only(bottom: 10.0),
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _posts[index].title,
                                style: kTextStyleSemiBold15.copyWith(
                                    fontSize: 17.0),
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                            ],
                          ),
                          subtitle: Text(
                            _posts[index].body,
                            style: kTextStyleRegular15,
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      );
    }

    if (state == HomeState.ERROR) {
      displayWidget = Center(child: Text("Error"));
    }

    return displayWidget;
  }

  @override
  void initState() {
    super.initState();

    BlocProvider.of<PostlyBloc>(context).add(GetPostlyDataEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kAccentColor,
          title: Text(
            "Postly",
            style: kAppBarStyle,
          ),
        ),
        body: BlocProvider.value(
          value: BlocProvider.of<PostlyBloc>(context),
          child: BlocConsumer<PostlyBloc, PostlyStates>(
            listener: (context, state) {
              if (state is FetchedDataState) {
                _user = state.user;
                _posts = state.posts;
                setState(() => _homeState = HomeState.LOADED);

                if (_user.points > 16) {
                  _showMyDialog();
                }
              } else if (state is OnErrorState) {
                _errorMessage = state.errorMessage;
                setState(() => _homeState = HomeState.ERROR);
              } else if (state is NavigateToCreatePostState) {
                Navigator.pushNamed(context, CreatePost.id);
              } else if (state is CreatePostState) {
                _posts.insert(0, state.newPost);
                _user.points = _user.points + 2;

                updateUserPointLocally();
                setState(() {});
              }
            },
            builder: (context, state) {
              return widgetToDisplay(_homeState);
            },
          ),
        ),
        floatingActionButton: Visibility(
          visible: _homeState == HomeState.LOADED,
          child: FloatingActionButton.extended(
            backgroundColor: Color(0xff210A54),
            onPressed: floatingButtonClickHandler,
            label: AnimatedSwitcher(
              duration: Duration(milliseconds: 800),
              transitionBuilder: (Widget child, Animation<double> animation) =>
                  FadeTransition(
                opacity: animation,
                child: SizeTransition(
                  child: child,
                  sizeFactor: animation,
                  axis: Axis.horizontal,
                ),
              ),
              child: _isScrolling
                  ? Icon(Icons.add)
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.add,
                          color: kSecondaryColor,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          "Create post",
                          style:
                              kTextStyleBold15.copyWith(color: kSecondaryColor),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
