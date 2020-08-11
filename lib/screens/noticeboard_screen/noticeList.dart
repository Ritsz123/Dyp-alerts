import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dypalerts/constants/constants.dart';
import 'package:dypalerts/model/noticeModel.dart';
import 'package:dypalerts/screens/noticeboard_screen/noticeTile.dart';
import 'package:dypalerts/services/database.dart';
import 'package:flutter/material.dart';

class NoticeList extends StatefulWidget {
  @override
  _NoticeListState createState() => _NoticeListState();
}

class _NoticeListState extends State<NoticeList> {
  final noticeStream = Firestore.instance
      .collection('notices')
      .orderBy("timeAdded", descending: true)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: noticeStream,
      builder: (context, snapshot) {
        //loading
        if (!snapshot.hasData) return loadingIndicator;
        //list of notices from database
        List<NoticeModel> _list = DatabaseService().getNoticeList(snapshot);

        return ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index) => Card(
            elevation: 5,
            margin: EdgeInsets.all(5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: NoticeTile(
              notice: _list[index],
            ),
          ),
        );
      },
    );
  }
}
