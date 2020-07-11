import 'package:dypalerts/constants/constants.dart';
import 'package:dypalerts/model/noticeModel.dart';
import 'package:dypalerts/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/getwidget.dart';

class NoticeBoardScreen extends StatefulWidget {
  @override
  _NoticeBoardScreenState createState() => _NoticeBoardScreenState();
}

class _NoticeBoardScreenState extends State<NoticeBoardScreen> {
  bool back = false;

  void openSingleNotice(int index) {
    print("Notice at index $index");
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
                openSingleNotice(index);
              },
              child: Card(
                elevation: 5,
                child: GFListTile(
                  padding: EdgeInsets.all(0),
                  avatar: GFAvatar(
                    backgroundColor: Colors.lightGreenAccent,
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          '${_list[index].title}',
                          style: kNoticeTitle,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            _list[index]
                                .time[0]
                                .value, //0 for hours & 1 for date
                            style: kNoticeTime,
                          ),
                          Text(
                            _list[index].time[1].value,
                            style: kNoticeTime,
                          ),
                        ],
                      ),
                    ],
                  ),
                  subTitle: Text(
                    '- ${_list[index].author}',
                    style: kNoticeAuthor,
                  ),
                ),
              ),
            ),

//                ExpansionTile(
////              leading: Icon(Icons.bookmark),
//              title: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: [
//                  Flexible(
//                    child: Text(
//                      '${_list[index].title}',
//                      style: kNoticeTitle,
//                    ),
//                  ),
//                  Column(
//                    children: [
//                      Text(
//                        _list[index].time[0].value, //0 for hours & 1 for date
//                        style: kNoticeTime,
//                      ),
//                      Text(
//                        _list[index].time[1].value,
//                        style: kNoticeTime,
//                      ),
//                    ],
//                  ),
//                ],
//              ),
//              subtitle: Text(
//                '- ${_list[index].author}',
//                style: kNoticeAuthor,
//              ),
//              children: [
//                Card(
//                  child: Column(
//                    children: [
//                      Text(
//                        "I'm trying to create a line in which center text has a maximum size, and if the text content is too large, it fits in size ",
//                        style: kNoticeTitle,
//                      ),
//                      Text('Children 2'),
//                    ],
//                  ),
//                ),
//              ],
////              backgroundColor:
////                  back ? Colors.lightBlueAccent : Colors.lightGreenAccent,
//              onExpansionChanged: (b) {
//                print(b);
//              },
//              childrenPadding: EdgeInsets.all(10),
//              initiallyExpanded: index == 0 ? true : false,
//            ),
//           todo:Build notice layout
          );
        },
      ),
    );
  }
}
