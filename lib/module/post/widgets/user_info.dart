import 'package:Postly/configs/app_config.dart';
import 'package:Postly/di.dart';
import 'package:Postly/module/post/model/user/user.dart';
import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  User user = ioc.get<User>();

  @override
  Widget build(BuildContext context) {
    var labelStyle = TextStyle(
        fontSize: getTextSize(context, size: 24), color: Colors.white);
    return Container(
      color: Colors.blue,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hi,",
                      style: labelStyle,
                    ),
                    SizedBox(height: 10),
                    Text("${user.name}", style: labelStyle)
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    "assets/images/profile_pic.jpg",
                    height: 50,
                    width: 50,
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width * 0.4, 0),
              child: getWidget(points: user.points),
            )
          ],
        ),
      ),
    );
  }

  // return user's Badge widget based on the points provided
  Widget getWidget({int points}) {
    UserBadge badge = getUserBadgeType(points);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/${badge.imageBadge}",
          height: 50,
          width: 50,
        ),
        Text("${badge.title}")
      ],
    );
  }

  // Get user's Badge based on the point provided
  UserBadge getUserBadgeType(int points) {
    if (points < 6) {
      return UserBadge.beginner;
    } else if (points >= 6 && points < 10) {
      return UserBadge.intermediate;
    } else {
      return UserBadge.professional;
    }
  }
}

enum UserBadge { beginner, intermediate, professional }

extension UserBadgeExt on UserBadge {
  String get imageBadge {
    switch (this) {
      case UserBadge.beginner:
        return "beginner-badge.png";

      case UserBadge.intermediate:
        return "intermediate-badge.png";

      default:
        return "professional-badge.png";
    }
  }

  String get title {
    switch (this) {
      case UserBadge.beginner:
        return "Beginner";

      case UserBadge.intermediate:
        return "Intermediate";

      default:
        return "Professional";
    }
  }
}
