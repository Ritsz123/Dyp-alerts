import 'package:dypalerts/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<bool> signInWithGoogle() async {
    final GoogleSignInAccount googleAccount = await _googleSignIn.signIn();
    if (googleAccount == null) return false;
    final GoogleSignInAuthentication googleAuth =
        await googleAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
    try {
      AuthResult result = await _auth.signInWithCredential(credential);

      if (result.user == null) {
        return false;
      } else {
        DatabaseService(uid: result.user.uid).updateUser(
            result.user.displayName,
            result.user.photoUrl,
            result.user.email); //for database //TODO:Update this
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> signOutGoogle() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
