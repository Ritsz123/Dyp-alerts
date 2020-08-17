import 'package:dypalerts/constants/constants.dart';
import 'package:dypalerts/model/userModel.dart';
import 'package:dypalerts/screens/discuss_screen/discussScreen.dart';
import 'package:dypalerts/screens/home_screen/dashCard.dart';
import 'package:dypalerts/screens/login_screen/newUserRegistrationScreen.dart';
import 'package:dypalerts/screens/noticeboard_screen/noticeboardScreen.dart';
import 'package:dypalerts/screens/profileScreen.dart';
import 'package:dypalerts/services/auth.dart';
import 'package:dypalerts/services/database.dart';
import 'package:dypalerts/services/provider.dart';
import 'package:dypalerts/widgets/background.dart';
import 'package:dypalerts/widgets/userInfoContainer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:page_transition/page_transition.dart';

class NewHomeScreen extends StatefulWidget {
  @override
  _NewHomeScreenState createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  bool isLoading = true;
  final DatabaseService dbService = DatabaseService();
  UserModel currentUser; //actual data of user from database

//Dummy data

  @override
  void initState() {
    super.initState();
    checkNewUser(); //to check & decide whether to display datainput screen
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of(context).auth;
    return LoadingOverlay(
      isLoading: isLoading,
      child: isLoading
          ? Scaffold(
              body: loadingIndicator,
            )
          : Scaffold(
              body: Stack(
                children: [
                  BackgroundContainer(),
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          UserInfoContainer(user: currentUser),
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
                                  onTap: () async {
                                    await auth.signout();
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
      UserModel usrdata = await dbService.getUserDataFromDatabase();
      setState(() {
        currentUser = usrdata;
        isLoading = false;
      });
    }
  }
}
