class UserModel {
  String uid;
  String name;
  String phone;
  String email;
  String studyYear;
  DateTime dob;
  String dept;
  String profileUrl;

  UserModel({
    this.dept,
    this.dob,
    this.email,
    this.name,
    this.phone,
    this.profileUrl,
    this.studyYear,
    this.uid,
  });
}
