import 'package:dypalerts/constants/constants.dart';
import 'package:flutter/material.dart';
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
        child: LoadingOverlay(
          isLoading: true,
          progressIndicator: loadingIndicator,
          child: Center(
              child: Text(
            'Discussion Screen',
            style: TextStyle(fontSize: 25),
          )),
        ),
      ),
    );
  }
}
