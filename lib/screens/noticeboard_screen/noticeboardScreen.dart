import 'package:dypalerts/model/userModel.dart';
import 'package:dypalerts/screens/noticeboard_screen/noticeList.dart';
import 'package:dypalerts/commonWidgets/background.dart';
import 'package:dypalerts/commonWidgets/userInfoContainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoticeBoardScreen extends StatelessWidget {
  NoticeBoardScreen({@required this.currentUser});
  final UserModel currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: NoticeList(),
                  ),
                  // Expanded(
                  //   child:
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
