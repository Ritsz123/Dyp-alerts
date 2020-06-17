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
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => Container(
                  //TODO: build the notice layout
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
