import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dypalerts/screens/home_screen/drawer.dart';
import 'package:dypalerts/screens/home_screen/drawerOptionNumberProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static final id = 'homeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DrawerOptionNumberProvider>(
      create: (context) => DrawerOptionNumberProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Dyp Alerts'),
        ),
        drawer: CustomAppDrawer(),
        body: SafeArea(
          child: Container(
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
          ),
        ),
      ),
    );
  }
}
