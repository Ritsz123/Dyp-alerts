import 'package:dypalerts/model/noticeModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:getwidget/getwidget.dart';

double screenWidth({@required context, @required divideBy}) {
  return MediaQuery.of(context).size.width / divideBy;
}

double screenHeight({@required context, @required divideBy}) {
  return MediaQuery.of(context).size.height / divideBy;
}

const loadingIndicator = SpinKitDualRing(
  color: Colors.blue,
);

const kNoticeTitle = TextStyle(fontSize: 20);
const kNoticeAuthor = TextStyle(fontSize: 14);
const kNoticeTime = TextStyle(fontSize: 14);
