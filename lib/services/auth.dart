import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

abstract class AuthBase {
  Stream<String> get onAuthStateChanged;

  Future<void> signout();

  Future<String> signinWithGoogle();

  Future<String> signinWithFacebook();

  Future<String> getCurrentUserID();
}

class AuthProvider implements AuthBase {
  final FacebookLogin _facebookLogin = FacebookLogin();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<String> signinWithFacebook() async {
    try {
      final result = await _facebookLogin.logIn(['email']);

      final AuthCredential credential = FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token);
      FirebaseUser user =
          (await _firebaseAuth.signInWithCredential(credential)).user;

      return user.uid;
    } catch (e) {
      print('Exception in fb login: $e');
      return null;
    }
  }

  @override
  Future<String> signinWithGoogle() async {
    try {
      final GoogleSignInAccount account = await _googleSignIn
          .signIn()
          .catchError((onError) => print(onError.toString()));
      if (account == null) return null;
      final GoogleSignInAuthentication _googleAuth =
          await account.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: _googleAuth.idToken,
        accessToken: _googleAuth.accessToken,
      );
      FirebaseUser user =
          (await _firebaseAuth.signInWithCredential(credential)).user;
      return user.uid;
    } catch (e) {
      print('Exception in google login: $e');
      return null;
    }
  }

  @override
  Future<void> signout() {
    return FirebaseAuth.instance.signOut();
  }

  Stream<String> get onAuthStateChanged =>
      _firebaseAuth.onAuthStateChanged.map((FirebaseUser user) => user?.uid);

  // GET UID
  Future<String> getCurrentUserID() async {
    return (await _firebaseAuth.currentUser()).uid;
  }
}
