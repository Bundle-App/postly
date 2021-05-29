import 'package:Postly/cubit/user_cubit.dart';
import 'package:Postly/screen/homepage.dart';
import 'package:Postly/util/constants.dart';
import 'package:Postly/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitialScreen extends StatefulWidget {
  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<UserCubit>().retrieveUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      return state is UserActive
          ? Homepage(
              user: state.user,
            )
          : state is UserInactive
              ? _errorWidget(context, state.error)
              : _loader();
    }));
  }

  Widget _loader() => Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(AppColors.primary),
          strokeWidth: 1,
        ),
      );

  Widget _errorWidget(BuildContext context, String error) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(
            'assets/png/error.png',
          ),
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
            text: 'Refresh',
            image: 'assets/png/refresh.png',
            onClick: () {
              context.read<UserCubit>().retrieveUser();
            },
            fillWidth: false,
          )
        ],
      );
}
