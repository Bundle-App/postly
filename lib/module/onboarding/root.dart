import 'package:Postly/configs/app_config.dart';
import 'package:Postly/di.dart';
import 'package:Postly/module/post/bloc/postly_bloc.dart';
import 'package:Postly/module/post/model/user/user.dart';
import 'package:Postly/module/post/root.dart';
import 'package:Postly/utils/helpers/route_animation.dart';
import 'package:Postly/utils/widgets/button.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding>
    with SingleTickerProviderStateMixin {
  var begin = 0.0;
  var end = 1.0;
  AnimationController _animationController;
  Animation _animation1;
  Animation _animation2;
  Animation _animation3;

  @override
  void initState() {
    // if user Object is not register fetch User's data
    if (!ioc.isRegistered<User>()) {
      ioc.get<PostlyBloc>().add(GetUsers());
    }
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animation1 = Tween(begin: begin, end: end).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.1, 0.3, curve: Curves.ease)));
    _animation2 = Tween(begin: begin, end: end).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.4, 0.7, curve: Curves.ease)));
    _animation3 = Tween(begin: begin, end: end).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.7, 1.0, curve: Curves.ease)));
    _animationController
      ..forward()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Column(
            children: [
              Image.asset(
                "assets/images/onboarding-image.png",
                height: MediaQuery.of(context).size.height * 0.7,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Opacity(
                opacity: _animation1.value,
                child: Text(
                  "Welcome to Postly",
                  style: TextStyle(fontSize: getTextSize(context, size: 24)),
                ),
              ),
              SizedBox(height: 20),
              Transform.scale(
                scale: _animation2.value,
                child: Text(
                  "A place to post content and earn a badge/point \n We are happy to have you joined us!",
                  style: TextStyle(fontSize: getTextSize(context, size: 20)),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 60),
              Opacity(
                opacity: _animation3.value,
                child: MyButton(
                  onTap: () {
                    Navigator.of(context).pushReplacement(FadeRoute(
                        page: MyHomePage(
                      title: "HomePage",
                    )));
                  },
                  height: 50.0,
                  width: MediaQuery.of(context).size.width * 0.9,
                  title: "Get Started",
                ),
              )
            ],
          );
        },
      )),
    );
  }
}
