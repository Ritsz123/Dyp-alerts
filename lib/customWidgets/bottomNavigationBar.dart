import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black54,
      shape: CircularNotchedRectangle(),
      child: IconTheme(
        data: IconThemeData(
          color: Theme.of(context).accentColor,
        ),
        child: Row(
          children: [
            Spacer(),
            IconButton(
              iconSize: 30,
              icon: Icon(Icons.account_circle),
              onPressed: () {
                //open app drawer
              },
            ),
          ],
        ),
      ),
    );
  }
}
