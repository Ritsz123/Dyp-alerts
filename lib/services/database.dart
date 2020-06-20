import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  DatabaseService({this.uid});
  final String uid;
  final CollectionReference userCollection =
      Firestore.instance.collection('users');
  Future updateUser(String name, String profileUrl, String email) async {
    return await userCollection
        .document(uid)
        .setData({'name': name, 'profileUrl': profileUrl, 'email': email});
  }
}
