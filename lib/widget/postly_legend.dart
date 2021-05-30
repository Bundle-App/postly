
import 'package:Postly/util/constants.dart';
import 'package:flutter/material.dart';

class PostlyLegend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          Align(
            alignment: Alignment.topRight,
            child:  IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  color: AppColors.grey,
                  size: 20,
                ),
              )
          ),

          Image.asset('assets/png/celebrate.jpg',width: MediaQuery.of(context).size.width*.7,),

          Text(
            'You are a Postly\nLegend!',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 22),
          ),

          SizedBox(height: 40,)
        ],
      ),
    );
  }
}
