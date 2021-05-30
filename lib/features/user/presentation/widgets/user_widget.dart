import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postly/core/utils/app_colors.dart';
import 'package:postly/core/utils/user_badge.dart';

import 'package:postly/features/user/presentation/notifiers/user_state.dart';
import 'package:postly/features/user/presentation/screens/home.dart';

import '../../../../core/utils/extensions.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({
    Key? key,
    required this.userBadge,
  }) : super(key: key);

  final UserBadge userBadge;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Consumer(
        builder: (context, watch, child) {
          var state = watch(userProvider);
          var points = watch(pointsNotifier);

          if (state is UserLoading) {
            return const CircularProgressIndicator();
          } else if (state is UserLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to Postly ${state.user.username}!',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: context.screenWidth(0.05)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: context.screenWidth(0.02)),
                    const Text(
                      'Level  ',
                      style: TextStyle(
                        color: AppColors.semiBlack,
                      ),
                    ),
                    Text(
                      userBadge.getUserBadge(points),
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.orangeAccent,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.screenHeight(0.05)),
                const Text(
                  'Posts',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.semiBlack,
                  ),
                ),
              ],
            );
          } else if (state is UserError) {
            return Text(state.message);
          }
          return Container();
        },
      ),
    );
  }
}
