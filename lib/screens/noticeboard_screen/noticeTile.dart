import 'package:dypalerts/constants/constants.dart';
import 'package:dypalerts/model/noticeModel.dart';
import 'package:dypalerts/screens/noticeboard_screen/SingleNoticeScreen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class NoticeTile extends StatelessWidget {
  NoticeTile({@required this.notice, this.maketextbold = false});
  final NoticeModel notice;
  final bool maketextbold;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeftWithFade,
            child: SingleNoticeScreen(
              notice: notice,
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
              style: kNoticeTitle.copyWith(
                fontWeight: maketextbold ? FontWeight.bold : FontWeight.normal,
              ),
              softWrap: true,
              textAlign: TextAlign.left,
              maxLines: 3,
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
    );
  }
}
