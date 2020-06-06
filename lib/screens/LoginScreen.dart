import 'package:dypalerts/screens/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginScreen extends StatefulWidget {
  static final id = 'loginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  void _processLogin() async {
    Future.delayed(Duration(seconds: 5), () {
      _toggleLoading();
      Navigator.pushNamed(context, HomeScreen.id);
    });
    print('Loading...');
    _toggleLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LoadingOverlay(
          progressIndicator: SpinKitDualRing(
            color: Colors.white,
          ),
          isLoading: _isLoading,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Image(
                          image: AssetImage('assets/images/back.jpg'),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'DYP Alerts',
                        style: TextStyle(
                          fontSize: 35.0,
                        ),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange[400],
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(270),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //login with google button
                    SignInButton(
                      Buttons.Google,
                      text: 'Login with Google',
                      onPressed: () {
                        _processLogin();
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SignInButton(
                      Buttons.Facebook,
                      text: 'Login with Facebook',
                      onPressed: () {
                        _processLogin();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
