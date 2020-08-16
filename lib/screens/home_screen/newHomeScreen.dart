import 'package:dypalerts/constants/constants.dart';
import 'package:dypalerts/screens/discuss_screen/discussScreen.dart';
import 'package:dypalerts/screens/home_screen/dashCard.dart';
import 'package:dypalerts/screens/login_screen/newUserRegistrationScreen.dart';
import 'package:dypalerts/screens/noticeboard_screen/noticeboardScreen.dart';
import 'package:dypalerts/screens/profileScreen.dart';
import 'package:dypalerts/services/auth.dart';
import 'package:dypalerts/services/database.dart';
import 'package:dypalerts/services/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';

class NewHomeScreen extends StatefulWidget {
  @override
  _NewHomeScreenState createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  bool isLoading = true;
  final DatabaseService dbService = DatabaseService();

  @override
  void initState() {
    super.initState();
    checkNewUser(); //to check & decide whether to display datainput screen
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of(context).auth;
    return isLoading
        ? Scaffold(
            body: loadingIndicator,
          )
        : Scaffold(
            body: Stack(
              children: [
                Container(
                  height: screenHeight(context: context, divideBy: 3),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      alignment: Alignment.topCenter,
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/bg.png'),
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Container(
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
                        ),
                        Expanded(
                          child: GridView.count(
                            crossAxisCount:
                                2, //Todo: detect if device rotated and change cross axis count accordingly 2 for vertical 3 for horizontal
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            primary: false,
                            children: [
                              DashCard(
                                label: 'NoticeBoard',
                                iconData: FontAwesomeIcons.clipboard,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.fade,
                                          child: NoticeBoardScreen()));
                                },
                              ),
                              DashCard(
                                label: 'Syllabus',
                                iconData: FontAwesomeIcons.newspaper,
                                onTap: () {
                                  //TODO:add functionality for syllabus
                                },
                              ),
                              DashCard(
                                label: 'Discussions',
                                iconData: FontAwesomeIcons.rocketchat,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.leftToRight,
                                        child: DiscussScreen(),
                                      ));
                                },
                              ),
                              DashCard(
                                label: 'Profile',
                                iconData: FontAwesomeIcons.user,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => ProfileScreen(),
                                    ),
                                  );
                                },
                              ),
                              DashCard(
                                onTap: () {
                                  auth.signout();
                                  // Navigator.pop(context);
                                },
                                label: 'Logout',
                                iconData: FontAwesomeIcons.powerOff,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  void checkNewUser() async {
    FirebaseUser user = await AuthProvider().getCurrentUser();
    if (user.metadata.creationTime.year == DateTime.now().year &&
        user.metadata.creationTime.month == DateTime.now().month &&
        user.metadata.creationTime.day == DateTime.now().day &&
        user.metadata.creationTime.hour == DateTime.now().hour &&
        user.metadata.creationTime.minute == DateTime.now().minute) {
      print("New user created");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NewUserRegScreen()),
      );
      // setState(() {
      //   isLoading = false;
      // });
    } else {
      print("Existing User");
      setState(() {
        isLoading = false;
      });
    }
  }
}
