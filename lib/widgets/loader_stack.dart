import 'package:Postly/theme/colors.dart';
import 'package:flutter/material.dart';

class LoaderStack extends StatelessWidget {
  final Widget child;
  final bool showLoader;

  const LoaderStack({Key key, @required this.child, @required this.showLoader})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (showLoader)
          Container(
            color: Colors.white.withOpacity(0.5),
            child: Center(
              child: Container(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(PostlyColors.bundlePurple),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
