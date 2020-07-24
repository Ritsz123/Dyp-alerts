import 'package:dypalerts/constants/constants.dart';
import 'package:flutter/material.dart';

class DashCard extends StatelessWidget {
  DashCard({this.iconData, this.label, @required this.onTap});

  final IconData iconData;
  final String label;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('$label pressed.');
        //TODO: add functionality
        onTap();
      },
      child: Card(
        elevation: 2.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: screenHeight(context: context, divideBy: 10),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              label,
              style: kCardTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
