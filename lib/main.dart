import 'file:///D:/Work/dyp%20project/github/Dyp-alerts/lib/screens/home_screen/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'screens/login_screen/LoginScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dyp Alerts',
      initialRoute: LoginScreen.id,
      routes: {
        '/': (context) => LoginScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        HomeScreen.id: (context) => HomeScreen(),
      },
    );
  }
}
