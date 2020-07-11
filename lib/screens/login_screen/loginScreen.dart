import 'package:dypalerts/constants/constants.dart';
import 'package:dypalerts/screens/home_screen/homeScreen.dart';
import 'package:dypalerts/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
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
              Container(
                height: screenHeight(context: context, divideBy: 1.5),
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth(context: context, divideBy: 10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Image(
                        image: AssetImage('assets/images/logo.png'),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'DYP Alerts',
                      style: TextStyle(
                        fontSize: screenHeight(context: context, divideBy: 20),
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.orange[400],
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(
                        screenHeight(context: context, divideBy: 2.5)),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight(context: context, divideBy: 16),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth(context: context, divideBy: 10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenHeight(context: context, divideBy: 18),
                      child: SignInButton(
                        Buttons.Google,
                        shape:
                            RoundedRectangleBorder(side: BorderSide(width: 1)),
                        onPressed: () async {
                          _toggleLoading();
                          bool res = await AuthProvider().signInWithGoogle();
                          if (!res) {
                            print('Login Failed');
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: screenHeight(context: context, divideBy: 18),
                      child: SignInButton(
                        Buttons.Facebook,
                        shape:
                            RoundedRectangleBorder(side: BorderSide(width: 1)),
                        onPressed: () {
                          _processLogin();
                        },
                      ),
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
