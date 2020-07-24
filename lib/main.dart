import 'package:dypalerts/constants/constants.dart';
import 'package:dypalerts/screens/home_screen/homeScreen.dart';
import 'package:dypalerts/screens/home_screen/newHomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'screens/login_screen/loginScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dyp Alerts',
      theme: ThemeData.light(),
      home: NewHomeScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: loadingIndicator,
          );
        if (!snapshot.hasData || snapshot.data == null) return LoginScreen();
        return HomeScreen();
      },
    );
  }
}
