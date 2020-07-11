import 'package:dypalerts/constants/constants.dart';
import 'package:getwidget/getwidget.dart';

import 'package:flutter/material.dart';

class NoticeModel {
  NoticeModel({this.title, this.description, this.author, this.time});
  final String title;
  final String description;
  final String author;
  final List<MapEntry> time;
}

GFListTile getBuildNoticeTile(NoticeModel notice) {
  return GFListTile(
    padding: EdgeInsets.all(0),
    avatar: GFAvatar(
      backgroundColor: Colors.lightGreenAccent,
    ),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            notice.title,
            style: kNoticeTitle,
          ),
        ),
        Column(
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
      ],
    ),
    subTitle: Text(
      '- ${notice.author}',
      style: kNoticeAuthor,
    ),
  );
}
