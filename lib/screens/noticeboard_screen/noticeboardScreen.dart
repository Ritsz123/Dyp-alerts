import 'package:dypalerts/constants/constants.dart';
import 'package:dypalerts/model/noticeModel.dart';
import 'package:dypalerts/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoticeBoardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: screenHeight(context: context, divideBy: 3),
            decoration: BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.topCenter,
                fit: BoxFit.cover,
                image: AssetImage('assets/images/bg.png'),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    height: 64,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.yellowAccent,
                          //TODO: remove background color & add background image
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Ritesh Khadse',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              'TE comp',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: Firestore.instance
                          .collection('notices')
                          .orderBy("timeAdded", descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        //loading
                        if (!snapshot.hasData) return loadingIndicator;
                        //list of notices from database
                        List<NoticeModel> _list =
                            DatabaseService().getNotices(snapshot);

                        return ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) => Card(
                            elevation: 5,
                            margin: EdgeInsets.all(5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: NoticeTile(
                              notice: _list[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
