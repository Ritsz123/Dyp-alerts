import 'package:flutter/cupertino.dart';

double screenWidth({context, divideBy}) {
  return MediaQuery.of(context).size.width / divideBy;
}

double screenHeight({context, divideBy}) {
  return MediaQuery.of(context).size.height / divideBy;
}
