import 'package:flutter/material.dart';

class FutureErrorDisplay extends StatelessWidget {
  final String message;
  final Function() onRetry;

  const FutureErrorDisplay({
    Key? key,
    required this.message,
    required this.onRetry,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '$message',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 20),
        TextButton(
          onPressed: onRetry,
          child: Text(
            'TRY AGAIN',
          ),
        ),
      ],
    );
  }
}
