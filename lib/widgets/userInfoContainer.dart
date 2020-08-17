import 'package:flutter/material.dart';

class UserInfoContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      height: 64,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: 'profilePic',
            child: CircleAvatar(
              radius: 35,
              backgroundColor: Colors.yellowAccent,
              //TODO: remove background color & add background image
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Ritesh Khadse',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'TE comp',
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
