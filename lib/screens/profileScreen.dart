import 'package:dypalerts/constants/constants.dart';
import 'package:dypalerts/model/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({@required this.currentUser});
  final UserModel currentUser;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(35),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment.topCenter,
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/bg.png'),
                  ),
//                  gradient: LinearGradient(
//                    colors: [Color(0xfff12711), Color(0xfff5af19)],
//                    stops: [0.0, 0.7],
//                  ),
                ),
                child: Column(
                  children: [
                    Card(
                      child: Hero(
                        tag: 'profilePic',
                        child: CircleAvatar(
                          radius: screenHeight(context: context, divideBy: 13),
                          backgroundColor: Colors.yellowAccent,
                          backgroundImage: widget.currentUser.profileUrl != null
                              ? NetworkImage(widget.currentUser.profileUrl)
                              : AssetImage('assets/images/profile_default.png'),
                        ),
                      ),
                      elevation: 10,
                      shape: CircleBorder(),
                      clipBehavior: Clip.antiAlias,
                    ),
                    Text(
                      widget.currentUser.name,
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.currentUser.email,
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(15),
                  children: [
                    Align(
                      child: Text(
                        'Account Info',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    UserInfoTile(
                      title: 'Name',
                      info: widget.currentUser.name,
                    ),
                    UserInfoTile(
                      title: 'Mobile',
                      info: widget.currentUser.phone,
                    ),
                    UserInfoTile(
                      title: 'Email',
                      info: widget.currentUser.email,
                    ),
                    // isEditing? :
                    UserInfoTile(
                      title: "Study Year",
                      info: widget.currentUser.studyYear,
                    ),
                    UserInfoTile(
                      title: 'D.O.B.',
                      info: DateFormat('dd MMM yyyy')
                          .format(widget.currentUser.dob),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UserInfoTile extends StatelessWidget {
  UserInfoTile({@required this.title, @required this.info});
  final String title;
  final String info;
  @override
  Widget build(BuildContext context) {
    return ListTile(
//      padding: EdgeInsets.all(0),
      title: Text(
        title,
        style: kProfileDescTitle,
      ),

      subtitle: Text(
        info,
        style: kProfileDescInfo,
      ),
    );
  }
}
