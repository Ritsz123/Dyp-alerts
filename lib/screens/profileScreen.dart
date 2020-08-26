import 'dart:io';
import 'package:dypalerts/commonWidgets/customImagePicker.dart';
import 'package:dypalerts/constants/constants.dart';
import 'package:dypalerts/model/userModel.dart';
import 'package:dypalerts/services/auth.dart';
import 'package:dypalerts/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditing = false;
  AuthProvider _auth;
  UserModel currentUser;

  @override
  Widget build(BuildContext context) {
    currentUser = context.watch<UserModel>();
    _auth = Provider.of<AuthProvider>(context);
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
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        String uid = await _auth.getCurrentUserID();
                        File imageFile = await CustomImagePicker().pickImage();
                        DatabaseService(uid: uid)
                            .uploadImage(file: imageFile)
                            .then((url) {
                          currentUser.updateProfileUrl(newProfileUrl: url);
                        });
                      },
                      child: Stack(
                        children: [
                          Card(
                            child: Hero(
                              tag: 'profilePic',
                              child: CircleAvatar(
                                radius: screenHeight(
                                    context: context, divideBy: 13),
//                                backgroundColor: Colors.yellowAccent,
                                backgroundImage: currentUser.profileUrl != null
                                    ? NetworkImage(currentUser.profileUrl)
                                    : AssetImage(
                                        'assets/images/profile_default.png'),
                              ),
                            ),
                            elevation: 10,
                            shape: CircleBorder(),
                            clipBehavior: Clip.antiAlias,
                          ),
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: Icon(
                              Icons.camera_alt,
                              size: 26,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      currentUser.name,
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      currentUser.email,
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
                      info: currentUser.name,
                    ),
                    UserInfoTile(
                      title: 'Mobile',
                      info: currentUser.phone,
                    ),
                    UserInfoTile(
                      title: 'Email',
                      info: currentUser.email,
                    ),
                    // isEditing? :
                    UserInfoTile(
                      title: "Study Year",
                      info: currentUser.studyYear,
                    ),
                    UserInfoTile(
                      title: 'D.O.B.',
                      info: DateFormat('dd MMM yyyy').format(currentUser.dob),
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
