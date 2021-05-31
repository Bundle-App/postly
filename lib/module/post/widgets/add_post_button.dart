import 'package:Postly/configs/app_color.dart';
import 'package:flutter/material.dart';

class AddPostButton extends StatefulWidget {
  final VoidCallback onPressed;
  AddPostButton({this.onPressed});

  @override
  _AddPostButtonState createState() => _AddPostButtonState();
}

class _AddPostButtonState extends State<AddPostButton>
    with SingleTickerProviderStateMixin {
  var begin = 0.0;
  var end = 1.0;
  AnimationController _animationController;
  Animation _animation1;
  Animation _animation2;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation1 = Tween(begin: begin, end: end).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 0.5, curve: Curves.easeInOut)));
    _animation2 = Tween(begin: begin, end: end).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.6, 1.0, curve: Curves.easeInOut)));
    _animationController
      ..addListener(() {
        setState(() {});
      })
      ..repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Stack(
            children: [
              Transform.scale(
                scale: _animation1.value,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    color: AppColors.primaryColor.withOpacity(0.25),
                    height: 70,
                    width: 70,
                  ),
                ),
              ),
              Positioned(
                left: 7,
                top: 7,
                child: Transform.scale(
                  scale: _animation2.value,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      color: AppColors.primaryColor.withOpacity(0.35),
                      height: 55,
                      width: 55,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 17,
                top: 17,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                    ),
                    height: 35,
                    width: 35,
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
