import 'package:dypalerts/constants/constants.dart';
import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight(context: context, divideBy: 3),
      decoration: BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.topCenter,
          fit: BoxFit.cover,
          image: AssetImage('assets/images/bg.png'),
        ),
      ),
    );
  }
}
