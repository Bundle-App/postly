import 'package:Postly/models/user/user.dart';
import 'package:Postly/screens/post/index.dart';
import 'package:Postly/states/auth/auth.dart';
import 'package:Postly/theme/colors.dart';
import 'package:Postly/widgets/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static String route = '/splash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  Future<void> _userFuture;
  bool _navigatesToNext;

  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _assignUserFuture();
    _navigatesToNext = false;

    _controller = AnimationController(
        duration: const Duration(milliseconds: 1200),
        vsync: this,
        value: 0.5,
        lowerBound: 0.5,
        upperBound: 1);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) _controller.reverse();

      if (status == AnimationStatus.dismissed) _controller.forward();
    });
  }

  void _assignUserFuture() async {
    final authState = context.read<AuthState>();
    _userFuture = authState.getUser();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<void>(
        future: _userFuture,
        builder: (context, snapshot) {
          final hasError = snapshot.hasError &&
              snapshot.connectionState != ConnectionState.waiting;
          final errorMessage = snapshot.error?.toString();
          final doneWithoutError =
              (snapshot.connectionState == ConnectionState.done) && !hasError;

          WidgetsBinding.instance.addPostFrameCallback((_) async {
            if (doneWithoutError && mounted && !_navigatesToNext) {
              _navigatesToNext = true;
              await Navigator.pushReplacementNamed(
                context,
                PostsScreen.route,
              );
            }
          });

          return Container(
            child: Builder(builder: (context) {
              if (hasError) {
                return Center(
                  child: FutureErrorDisplay(
                    message: errorMessage,
                    onRetry: () {
                      setState(() {
                        _assignUserFuture();
                      });
                    },
                  ),
                );
              }

              return Container(
                child: Center(
                  child: FadeTransition(
                    opacity: _animation,
                    child: Text(
                      'Postly',
                      style: TextStyle(
                        fontSize: 50,
                        color: PostlyColors.bundlePurple,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
