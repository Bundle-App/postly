import 'package:postly/enums/app_state.dart';
import 'package:flutter/material.dart';

class POSTLYSuspense extends StatelessWidget {
  final AppState appState;
  final Widget loadingWidget;
  final Widget errorWidget;
  final Function(BuildContext widget) successWidget;

  const POSTLYSuspense({
    Key key,
    this.appState,
    this.errorWidget,
    this.successWidget,
    this.loadingWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (appState == AppState.none) {
      return successWidget(context);
    } else if (appState == AppState.loading) {
      return loadingWidget;
    } else {
      return errorWidget ?? Container();
    }
  }
}
