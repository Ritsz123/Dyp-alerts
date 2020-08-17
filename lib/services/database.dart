import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dypalerts/model/noticeModel.dart';
import 'package:dypalerts/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:dypalerts/model/userModel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection =
      Firestore.instance.collection('users');
  final CollectionReference noticeCollection =
      Firestore.instance.collection('notices');

  List<NoticeModel> getNoticeList(AsyncSnapshot snapshot) {
    List<NoticeModel> noticeList = [];
    String title, author, timeAddedHours, timeAddedDate, description;
    for (var snap in snapshot.data.documents) {
      title = snap['title'];
      author = snap['author'];
      description = snap['desc'];
      DateTime date = DateTime.parse(snap['timeAdded'].toDate().toString());
      timeAddedHours = DateFormat('hh:mm a,').format(date);
      timeAddedDate = DateFormat('dd MMM yyyy').format(date);
      noticeList.add(NoticeModel(
        description: description,
        author: author,
        title: title,
        time: [
          MapEntry('hrs', timeAddedHours),
          MapEntry('date', timeAddedDate)
        ], //timeAdded,
      ));
    }
    return noticeList;
  }

// create user in database
  Future updateUserDataInDatabase(UserModel user) async {
    if (uid == null || uid.isEmpty) return false;
    await userCollection.document(uid).setData({
      'name': user.name,
      'email': user.email,
      'phone': user.phone,
      'studyYear': user.studyYear,
      'dept': user.dept,
      'dob': user.dob,
      'profileUrl': user.profileUrl,
      'uid': user.uid,
    }).whenComplete(() {
      return true;
    });
  }

  Future<UserModel> getUserDataFromDatabase() async {
    String uid = await AuthProvider().getCurrentUserID();
    var docs = await userCollection.document(uid).get();
    print('Name: ${docs.data['name']}');
    var usr = docs.data;

    UserModel currentUser = UserModel(
      dept: usr['dept'],
      dob: usr['dob'].toDate(),
      email: usr['email'],
      name: usr['name'],
      phone: usr['phone'],
      profileUrl: usr['profileUrl'],
      studyYear: usr['studyYear'],
      uid: usr['uid'],
    );
    return currentUser;
  }

  Future<String> uploadImage(File image) async {
    String imageUrl;
    final StorageReference _storageReference = FirebaseStorage()
        .ref()
        .child('userData')
        .child('profilePics')
        .child(uid); //the name of file;
    print('uploading....');
    StorageTaskSnapshot snapshot =
        await _storageReference.putFile(image).onComplete;
    if (snapshot.error == null) {
      imageUrl = await snapshot.ref.getDownloadURL();
    } else {
      print('error in uploading image ${snapshot.error.toString()}');
    }
    print('Upload Successful:  $imageUrl');
    return imageUrl;
  }
}
