import 'package:dypalerts/model/popup_btn_options.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//popupbtn options
final List<PopUpBtnOption> _popupOptn = [
  PopUpBtnOption(title: 'About', icon: Icons.person),
  PopUpBtnOption(title: 'Logout', icon: FontAwesomeIcons.powerOff),
];

AppBar myAppBar = AppBar(
  title: Text('Dyp Alerts'),
  actions: [
    PopupMenuButton(
      itemBuilder: (context) {
        return _popupOptn.map((PopUpBtnOption po) {
          return PopupMenuItem(
            value: po,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  po.icon,
                  color: Colors.lightBlueAccent,
                ),
                Spacer(),
                Text(po.title),
              ],
            ),
          );
        }).toList();
      },
      onSelected: (selectedOption) {
        //operations to perform when option from PopUpMenu is selected
        if (selectedOption.title == 'Logout') {
          print('Logged out!');
        }
      },
    ),
  ],
);
