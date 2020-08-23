import 'package:dypalerts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_overlay/loading_overlay.dart';

class DiscussScreen extends StatefulWidget {
  @override
  _DiscussScreenState createState() => _DiscussScreenState();
}

class _DiscussScreenState extends State<DiscussScreen> {
  //TODO:Implement discussion screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/svgs/in_progress.svg",
                width: 250,
                semanticsLabel: "InProgress",
              ),
              Text(
                "Coming Soon..",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
