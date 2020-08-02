class UserModel {
  final String name;
  final String phone;
  final String email;
  final String studyYear;
  final DateTime dob;
  final String collegeDept;
  UserModel(
      {this.collegeDept,
      this.email,
      this.name,
      this.dob,
      this.phone,
      this.studyYear});
}
