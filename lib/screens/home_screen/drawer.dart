import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Ritesh Khadse'),
            accountEmail: Text('Someemail@ds.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/logo.png'),
            ),
          ),
          ListTile(
            selected: true,
            leading: Icon(FontAwesomeIcons.clipboard),
            title: Text('NoticeBoard'),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.rocketchat),
            title: Text('Chats'),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.rocketchat),
            title: Text('Chats'),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.rocketchat),
            title: Text('Chats'),
          ),
          Divider(),
          ListTile(
            leading: Icon(FontAwesomeIcons.share),
            title: Text('Share'),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.powerOff),
            title: Text('Logout'),
          ),
        ],
      ),
    );
  }
}
