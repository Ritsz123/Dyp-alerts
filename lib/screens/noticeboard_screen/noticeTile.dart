import 'package:dypalerts/constants/constants.dart';
import 'package:dypalerts/model/noticeModel.dart';
import 'package:dypalerts/screens/noticeboard_screen/SingleNoticeScreen.dart';
import 'package:flutter/material.dart';

class NoticeTile extends StatelessWidget {
  NoticeTile({@required this.notice});
  final NoticeModel notice;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SingleNoticeScreen(
              noticeModel: notice,
            ),
          ),
        );
      },
      // actual title
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              notice.title,
              style: kNoticeTitle,
              softWrap: true,
              textAlign: TextAlign.left,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      // author name
      subtitle: Text(
        '- ${notice.author}',
        style: kNoticeAuthor,
      ),
      // for time
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            notice.time[0].value, //0 for hours & 1 for date
            style: kNoticeTime,
          ),
          Text(
            notice.time[1].value,
            style: kNoticeTime,
          ),
        ],
      ),

//      contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    );
  }
}
