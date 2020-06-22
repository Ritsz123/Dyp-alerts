import 'package:dypalerts/screens/discuss_screen/discussScreen.dart';
import 'package:dypalerts/screens/noticeboard_screen/noticeboardScreen.dart';
import 'package:dypalerts/screens/profileScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  static final id = 'homeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  final List<BottomNavigationBarItem> _tabList = [
    BottomNavigationBarItem(
      icon: Icon(
        FontAwesomeIcons.clipboard,
      ),
      title: Text('Notices'),
    ),
    BottomNavigationBarItem(
      icon: Icon(
        FontAwesomeIcons.rocketchat,
      ),
      title: Text('Discussions'),
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.account_circle,
      ),
      title: Text('Profile'),
    ),
  ];

  final List<Widget> _children = [
    NoticeBoardScreen(),
    DiscussScreen(),
    ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dyp Alerts'),
      ),
//        drawer: CustomAppDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 25,
        currentIndex: _currentIndex,
        elevation: 10,
        selectedIconTheme: IconThemeData(size: 30),
        items: _tabList,
        onTap: (index) => _onTabTapped(index),
      ),
      body: SafeArea(
        child: _children[_currentIndex],
      ),
    );
  }
}
