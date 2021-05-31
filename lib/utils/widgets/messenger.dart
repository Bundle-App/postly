import 'package:Postly/configs/app_color.dart';
import 'package:flutter/material.dart';

enum MessengerType { error, success }

extension MessengerTypeExt on MessengerType {
  Color get color {
    switch (this) {
      case MessengerType.success:
        return AppColors.successColor;
      case MessengerType.error:
        return AppColors.errorColor;

      default:
        return AppColors.successColor;
    }
  }
}

class MessengerWidget {
  static void sendMessage({
    @required String message,
    @required BuildContext context,
    MessengerType type = MessengerType.success,
  }) {
    Scaffold.of(context).showSnackBar(_getSnackBar(message, type));
  }

  static SnackBar _getSnackBar(message, MessengerType type) {
    return SnackBar(
      backgroundColor: type.color,
      content: Text(message),
      // action: SnackBarAction(
      //   label: 'UNDO',
      //   onPressed: () {
      //     // Some code to undo the change.
      //   },
      // ),
    );
  }
}
