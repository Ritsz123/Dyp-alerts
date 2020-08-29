import 'package:dypalerts/constants/constants.dart';
import 'package:dypalerts/model/userModel.dart';
import 'package:dypalerts/services/auth.dart';
import 'package:dypalerts/screens/home_screen/newHomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen/loginScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider<UserModel>(
          create: (context) => UserModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Dyp Alerts',
        theme: ThemeData.light(),
        home: MainScreen(),
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
