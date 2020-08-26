import 'package:dypalerts/model/userModel.dart';
import 'package:dypalerts/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class UserInfoContainer extends StatelessWidget {
  UserInfoContainer({this.user});
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
              Provider.of<AuthProvider>(context, listen: false).signout();
            },
          )
        ],
      ),
    );
  }
}
