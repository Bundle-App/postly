import 'package:Postly/models/user/user.dart';
import 'package:Postly/screens/dashboard.dart';
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

  @override
  void initState() {
    super.initState();

    _assignUserFuture();
    _navigatesToNext = false;
  }

  void _assignUserFuture() async {
    final authState = context.read<AuthState>();
    _userFuture = authState.getUser();
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
                DashboardScreen.route,
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

              return Container();
            }),
          );
        },
      ),
    );
  }
}
