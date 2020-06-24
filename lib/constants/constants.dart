import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

double screenWidth({@required context, @required divideBy}) {
  return MediaQuery.of(context).size.width / divideBy;
}

double screenHeight({@required context, @required divideBy}) {
  return MediaQuery.of(context).size.height / divideBy;
}

const loadingIndicator = SpinKitDualRing(
  color: Colors.blue,
);
