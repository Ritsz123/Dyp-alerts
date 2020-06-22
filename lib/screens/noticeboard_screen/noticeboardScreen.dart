import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoticeBoardScreen extends StatefulWidget {
  @override
  _NoticeBoardScreenState createState() => _NoticeBoardScreenState();
}

class _NoticeBoardScreenState extends State<NoticeBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: Firestore.instance.collection('notices').snapshots(),
        builder: (context, snapshot) {
          //TODO: Implement Loading widget
          if (!snapshot.hasData) return Text('Loading...');
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) => Container(
              //TODO: build the notice layout
              child: Column(
                children: [
                  Text(snapshot.data.documents[index]['title']),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
