import 'package:dypalerts/constants/constants.dart';
import 'package:dypalerts/model/noticeModel.dart';
import 'package:dypalerts/screens/noticeboard_screen/noticeTile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_file/open_file.dart';

class SingleNoticeScreen extends StatefulWidget {
  SingleNoticeScreen({@required this.notice});
  final NoticeModel notice;

  @override
  _SingleNoticeScreenState createState() => _SingleNoticeScreenState();
}

class _SingleNoticeScreenState extends State<SingleNoticeScreen> {
  String pdfPath = "";
  bool exists = true;
  @override
  void initState() {
    super.initState();
    if (widget.notice.hasAttachment) {
      createFileOfPDFUrl(widget.notice.pdfUrl).then((f) => {
            setState(() {
              pdfPath = f.path;
              print("PDF: $pdfPath");
            })
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    NoticeModel currentNotice = widget.notice;
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
                            OpenFile.open(pdfPath);
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
