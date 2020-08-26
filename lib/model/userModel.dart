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
    print("update current user");
    notifyListeners();
  }

  updateProfileUrl({String newProfileUrl}) {
    this.profileUrl = newProfileUrl;
    notifyListeners();
  }
}
