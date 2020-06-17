import 'package:flutter/cupertino.dart';

class DrawerOptionNumberProvider with ChangeNotifier {
  int _activeDrawerOptionNumber = 1;

  getActiveDrawerOptionNumber() {
    return _activeDrawerOptionNumber;
  }

  setActiveDrawerOptionNumber(int n) {
    _activeDrawerOptionNumber = n;
    notifyListeners();
  }
}
