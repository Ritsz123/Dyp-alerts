import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dypalerts/model/noticeModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class DatabaseService {
  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  Future<void> updateUser(
      String uid, String name, String email, String phoneNumber) async {
    return await userCollection
        .document(uid)
        .setData({'name': name, 'email': email, 'phoneNumber': phoneNumber});
  }

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
        ],

//        timeAdded,
      ));
    }

    return noticeList;
  }
}
