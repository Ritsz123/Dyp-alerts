import 'package:dypalerts/model/userModel.dart';
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
var kProfileDescInfo = TextStyle(fontSize: 20, color: Colors.blueGrey.shade700);

const kCardTextStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

// UserModel dummyUsr = UserModel(
//   dept: "Computer",
//   dob: DateTime.now(),
//   email: "riteshkhadse12@gmail.com",
//   name: "Ritesh Khadse",
//   phone: "7972771137",
//   profileUrl: "https://rb.gy/6lefmc",
//   studyYear: "TE",
//   uid: "SomerandomUId",
// );
