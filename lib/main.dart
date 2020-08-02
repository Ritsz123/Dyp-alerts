import 'package:dypalerts/constants/constants.dart';
import 'package:dypalerts/screens/login_screen/newUserDataInputScreen.dart';
import 'package:dypalerts/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:dypalerts/screens/home_screen/newHomeScreen.dart';
import 'package:flutter/material.dart';
import 'screens/login_screen/loginScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<AuthProvider>(
      create: (_) => AuthProvider(), //get user
      child: MaterialApp(
        title: 'Dyp Alerts',
        theme: ThemeData.light(),
        home: Scaffold(
          body: UserDataScreen(),
        ),
        //TODO: change to mainScreen
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthProvider auth = Provider.of<AuthProvider>(context);
    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? NewHomeScreen() : LoginScreen();
        }
        return Center(
          child: loadingIndicator,
        );
      },
    );
  }
}
