import 'package:dypalerts/model/noticeModel.dart';
import 'package:dypalerts/screens/noticeboard_screen/noticeTile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SingleNoticeScreen extends StatelessWidget {
  SingleNoticeScreen({@required this.notice});
  final NoticeModel notice;
  @override
  Widget build(BuildContext context) {
    NoticeModel currentNotice = notice;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //TODO:Share
        },
        child: Icon(FontAwesomeIcons.share),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('DYP Alerts'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 10),
          child: Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  NoticeTile(
                    notice: currentNotice,
                    maketextbold: true,
                  ),
                  Divider(
                    indent: 25,
                    endIndent: 25,
                    color: Colors.blueGrey,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      currentNotice.description,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  currentNotice.hasAttachment
                      ? RaisedButton(
                          elevation: 5,
                          onPressed: () {
                            print('open file');
                          },
                          child: Text('Open Attachment'),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
