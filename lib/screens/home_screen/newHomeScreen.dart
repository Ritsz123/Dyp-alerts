import 'package:dypalerts/constants/constants.dart';
import 'package:dypalerts/model/userModel.dart';
import 'package:dypalerts/screens/discuss_screen/discussScreen.dart';
import 'package:dypalerts/screens/home_screen/dashCard.dart';
import 'package:dypalerts/screens/login_screen/newUserRegistrationScreen.dart';
import 'package:dypalerts/screens/noticeboard_screen/noticeboardScreen.dart';
import 'package:dypalerts/screens/profileScreen.dart';
import 'package:dypalerts/services/auth.dart';
import 'package:dypalerts/services/database.dart';
import 'package:dypalerts/commonWidgets/background.dart';
import 'package:dypalerts/commonWidgets/userInfoContainer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class NewHomeScreen extends StatefulWidget {
  @override
  _NewHomeScreenState createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  bool isLoading = true;
  final DatabaseService dbService = DatabaseService();
  UserModel currentUser;
  AuthProvider auth;
  //actual data of user from database

  @override
  void initState() {
    super.initState();
    checkNewUser(); //to check & decide whether to display datainput screen
  }

  @override
  Widget build(BuildContext context) {
    auth = context.watch<AuthProvider>();
    currentUser = context.watch<UserModel>();
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
                                        child: NoticeBoardScreen(
                                          currentUser: currentUser,
                                        ),
                                      ),
                                    );
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
    bool isDataPresentInDB = await dbService.checkUserInDatabase();
    if (user.metadata.creationTime.year == DateTime.now().year &&
        user.metadata.creationTime.month == DateTime.now().month &&
        user.metadata.creationTime.day == DateTime.now().day &&
        user.metadata.creationTime.hour == DateTime.now().hour &&
        user.metadata.creationTime.minute == DateTime.now().minute) {
      print("New user created");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewUserRegScreen(),
        ),
      );
    } else {
      if (!isDataPresentInDB) {
        print("Existing user: no data in Database");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewUserRegScreen(
              showPopUp: true,
            ),
          ),
        );
      } else {
        print("Existing User: Data present in Database");
        UserModel usrdata = await dbService.getUserDataFromDatabase();
        currentUser.updateUser(user: usrdata);
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
