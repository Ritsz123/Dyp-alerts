import 'package:dypalerts/screens/home_screen/drawerOptionNumberProvider.dart';
import 'package:dypalerts/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CustomAppDrawer extends StatefulWidget {
  @override
  _CustomAppDrawerState createState() => _CustomAppDrawerState();
}

class _CustomAppDrawerState extends State<CustomAppDrawer> {
  void closeDrawer() {
    Navigator.pop(context); //close Drawer
  }

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
          DrawerOption(
            optionNum: 1,
            title: Text('NoticeBoard'),
            icon: Icon(FontAwesomeIcons.clipboard),
            onPressed: () {
              print('Noticeboard pressed');
              closeDrawer();
            },
          ),
          DrawerOption(
            optionNum: 2,
            icon: Icon(FontAwesomeIcons.rocketchat),
            title: Text('Chats'),
            onPressed: () {
              print('Chats Pressed');
              closeDrawer();
            },
          ),
          Divider(),
          DrawerOption(
            optionNum: 3,
            title: Text('Share'),
            icon: Icon(FontAwesomeIcons.share),
            onPressed: () {
              print('Share');
            },
          ),
          DrawerOption(
            icon: Icon(FontAwesomeIcons.powerOff),
            title: Text('Logout'),
            optionNum: 4,
            onPressed: () {
              //TODO: show progress indicator
              Future.delayed(Duration(seconds: 2), () {
                AuthProvider().signOutGoogle();
                print('Logged out');
              });
            },
          )
        ],
      ),
    );
  }
}

class DrawerOption extends StatelessWidget {
  DrawerOption(
      {@required this.optionNum,
      @required this.title,
      @required this.icon,
      @required this.onPressed});

  final int optionNum;
  final Icon icon;
  final Text title;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: Provider.of<DrawerOptionNumberProvider>(context)
                  .getActiveDrawerOptionNumber() ==
              optionNum
          ? true
          : false,
      leading: icon,
      title: title,
      onTap: () {
        Provider.of<DrawerOptionNumberProvider>(context, listen: false)
            .setActiveDrawerOptionNumber(
          optionNum,
        ); //update current active option
        onPressed(); //actual method
        print(Provider.of<DrawerOptionNumberProvider>(context, listen: false)
            .getActiveDrawerOptionNumber());
      },
    );
  }
}
