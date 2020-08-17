import 'package:dypalerts/screens/noticeboard_screen/noticeList.dart';
import 'package:dypalerts/widgets/background.dart';
import 'package:dypalerts/widgets/userInfoContainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoticeBoardScreen extends StatelessWidget {
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
                  // userInfo, //from UserInfoContainer
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
