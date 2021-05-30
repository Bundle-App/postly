import 'package:flutter/material.dart';

class LegendDialog extends StatelessWidget {
  final String username;

  const LegendDialog({
    Key? key,
    required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),

            SizedBox(height: 10),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Hey ',
                  ),
                  TextSpan(
                    text: username,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  TextSpan(
                    text: ',\nYou are a ',
                    style: TextStyle(fontSize: 20),
                  ),
                  TextSpan(
                    text: 'postly legend',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black
                ),
              ),
            ),
            SizedBox(height: 25),
            Row(
              children: [
                Expanded(child: SizedBox()),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 50,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'CLOSE',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
