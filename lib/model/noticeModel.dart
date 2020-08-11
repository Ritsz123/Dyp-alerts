import 'package:dypalerts/constants/constants.dart';
import 'package:dypalerts/screens/noticeboard_screen/SingleNoticeScreen.dart';
import 'package:flutter/material.dart';

class NoticeModel {
  NoticeModel({this.title, this.description, this.author, this.time});

  final String author;
  final String description;
  final List<MapEntry> time;
  final String title;
}
