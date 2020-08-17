import 'package:dypalerts/constants/constants.dart';
import 'package:dypalerts/model/userModel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserInfoContainer extends StatelessWidget {
  UserInfoContainer({@required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20, left: 5, right: 5),
      height: 75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Hero(
            tag: 'profilePic',
            child: CircleAvatar(
              radius: 38,
              backgroundImage: user.profileUrl != null
                  ? NetworkImage(user.profileUrl)
                  : AssetImage("assets/images/profile_default.png"),
            ),
          ),
          // SizedBox(
          //   width: 15,
          // ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                user.name,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text(
                user.studyYear.toUpperCase() + " " + user.dept,
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
          IconButton(
              icon: Icon(FontAwesomeIcons.powerOff),
              iconSize: 25,
              onPressed: () {
                //do me
              })
        ],
      ),
    );
  }
}

// Widget userInfo = UserInfoContainer(
//   user: ,
// );
