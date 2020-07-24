import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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

const kProfileDescTitle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
const kProfileDescInfo = TextStyle(fontSize: 20, color: Colors.blueGrey);

const kCardTextStyle = TextStyle(fontSize: 24);
