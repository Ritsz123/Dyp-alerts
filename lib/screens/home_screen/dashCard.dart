import 'package:dypalerts/constants/constants.dart';
import 'package:flutter/material.dart';

class DashCard extends StatelessWidget {
  DashCard({this.iconData, this.label});

  final IconData iconData;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 70,
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
    );
  }
}
