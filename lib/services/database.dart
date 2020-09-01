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
  final CollectionReference syllabusCollection =
      Firestore.instance.collection('syllabus');

  List<NoticeModel> getNoticeList(AsyncSnapshot snapshot) {
    List<NoticeModel> noticeList = [];
    String title,
        author,
        timeAddedHours,
        timeAddedDate,
        description,
        pdfUrl = "";
    bool hasAttachment;
    for (DocumentSnapshot snap in snapshot.data.documents) {
      var data = snap.data;

      title = data['title'];
      author = data['author'];
      description = data['desc'];
      hasAttachment = data['isAttachment'];
      hasAttachment ? pdfUrl = data['pdfUrl'] : pdfUrl = "";
      DateTime date = DateTime.parse(data['timeAdded'].toDate().toString());
      timeAddedHours = DateFormat('hh:mm a,').format(date);
      timeAddedDate = DateFormat('dd MMM yyyy').format(date);

      NoticeModel notice = NoticeModel(
        description: description,
        pdfUrl: pdfUrl,
        author: author,
        hasAttachment: hasAttachment,
        title: title,
        time: [
          MapEntry('hrs', timeAddedHours),
          MapEntry('date', timeAddedDate)
        ], //timeAdded,
      );

      noticeList.add(notice);
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

  Future<bool> checkUserInDatabase() async {
    bool isAvailable;
    await userCollection
        .where('uid', isEqualTo: uid)
        .getDocuments()
        .then((value) => {
              if (value.documents == null || value.documents.isEmpty)
                {isAvailable = false}
              else
                {isAvailable = true}
            });
    return isAvailable;
  }

  Future<bool> updateProfileUrl({String url}) async {
    await userCollection
        .document(uid)
        .updateData({'profileUrl': url}).then((value) {
      return true;
    });
    return false;
  }

  Future<String> getSyllabusUrl({String dept, String year}) async {
    var snap = await syllabusCollection.document(dept).get();
    return snap.data[year];
  }

  Future<String> uploadImage({File file}) async {
    String imageUrl;
    final StorageReference _storageReference = FirebaseStorage()
        .ref()
        .child('userData')
        .child('profilePics')
        .child(uid); //the name of file;
    print('uploading....');
    StorageTaskSnapshot snapshot =
        await _storageReference.putFile(file).onComplete;
    if (snapshot.error == null) {
      imageUrl = await snapshot.ref.getDownloadURL();
    } else {
      print('error in uploading image ${snapshot.error.toString()}');
    }
    print('Upload Successful:  $imageUrl');
    return imageUrl;
  }
}
