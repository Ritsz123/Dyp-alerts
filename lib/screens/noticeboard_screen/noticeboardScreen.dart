import 'package:dypalerts/constants/constants.dart';
import 'package:dypalerts/model/noticeModel.dart';
import 'package:dypalerts/screens/noticeboard_screen/SingleNoticeScreen.dart';
import 'package:dypalerts/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoticeBoardScreen extends StatefulWidget {
  @override
  _NoticeBoardScreenState createState() => _NoticeBoardScreenState();
}

class _NoticeBoardScreenState extends State<NoticeBoardScreen> {
  bool back = false;

  void openSingleNotice(NoticeModel notice) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SingleNoticeScreen(
          noticeModel: notice,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: Firestore.instance.collection('notices').snapshots(),
        builder: (context, snapshot) {
          //loading
          if (!snapshot.hasData) return loadingIndicator;
          //list of notices from database
          List<NoticeModel> _list = DatabaseService().getNotices(snapshot);
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) => FlatButton(
              onPressed: () {
                openSingleNotice(_list[index]);
              },
              child: Card(
                elevation: 5,
                child: getBuildNoticeTile(_list[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}
