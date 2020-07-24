import 'package:dypalerts/model/noticeModel.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class SingleNoticeScreen extends StatefulWidget {
  SingleNoticeScreen({@required this.noticeModel});
  final NoticeModel noticeModel;
  @override
  _SingleNoticeScreenState createState() => _SingleNoticeScreenState();
}

class _SingleNoticeScreenState extends State<SingleNoticeScreen> {
  @override
  Widget build(BuildContext context) {
    NoticeModel currentNotice = widget.noticeModel;
    return Scaffold(
      appBar: GFAppBar(),
      body: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            NoticeTile(
              notice: currentNotice,
            ),
            Text(
              currentNotice.description,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
