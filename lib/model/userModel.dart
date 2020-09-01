import 'package:dypalerts/services/database.dart';
import 'package:flutter/widgets.dart';

class UserModel with ChangeNotifier {
  String uid;
  String name;
  String phone;
  String email;
  String studyYear;
  DateTime dob;
  String dept;
  String profileUrl;

  UserModel({
    this.uid,
    this.dept,
    this.dob,
    this.email,
    this.name,
    this.phone,
    this.profileUrl,
    this.studyYear,
  });

  updateUser({UserModel user}) {
    this.dept = user.dept;
    this.dob = user.dob;
    this.email = user.email;
    this.name = user.name;
    this.phone = user.phone;
    this.profileUrl = user.profileUrl;
    this.studyYear = user.studyYear;
    this.uid = user.uid;
    notifyListeners();
  }

  updateProfileUrl({String newProfileUrl}) async {
    this.profileUrl = newProfileUrl;
    await DatabaseService(uid: uid).updateProfileUrl(url: newProfileUrl);
    notifyListeners();
  }

  String getDept() {
    return this.dept;
  }

  String getYear() {
    return this.studyYear;
  }
}
