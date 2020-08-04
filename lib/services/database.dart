import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dypalerts/model/noticeModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:dypalerts/model/userModel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class DatabaseService {
  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  List<NoticeModel> getNotices(AsyncSnapshot snapshot) {
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

  Future updateUserDataInDatabase(UserModel user) async {
    String userId = user.uid;
    return await userCollection.document(userId).setData({
      'name': user.name,
      'email': user.email,
      'phone': user.phone,
      'studyYear': user.studyYear,
      'dept': user.dept,
      'dob': user.dob,
      'profileUrl': user.profileUrl,
    });
  }

  Future<String> uploadImage(String imageName, File profileImage) async {
    final StorageReference _storageReference = FirebaseStorage()
        .ref()
        .child('userData')
        .child('profilePics')
        .child(imageName); //the name of file;
    _storageReference.putFile(profileImage);
    String imageUrl = await _storageReference.getDownloadURL();
    print('Upload Successful:  $imageUrl');
    return imageUrl;
  }
}
