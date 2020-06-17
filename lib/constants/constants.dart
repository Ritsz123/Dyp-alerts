import 'package:flutter/cupertino.dart';

double screenWidth({@required context, @required divideBy}) {
  return MediaQuery.of(context).size.width / divideBy;
}

double screenHeight({@required context, @required divideBy}) {
  return MediaQuery.of(context).size.height / divideBy;
}
