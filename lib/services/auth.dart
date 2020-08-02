import 'package:dypalerts/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider {
  DatabaseService dbService = DatabaseService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(
        (FirebaseUser user) => user.uid,
      );

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount account = await _googleSignIn.signIn();
    final GoogleSignInAuthentication _googleAuth = await account.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: _googleAuth.idToken,
      accessToken: _googleAuth.accessToken,
    );
    FirebaseUser user =
        (await _firebaseAuth.signInWithCredential(credential)).user;
    String userId = user.uid;
    //update data in database;
    return userId;
  }

  //get Current user
  Future getCurrentUser() async {
    return await _firebaseAuth.currentUser();
  }

  // GET UID
  Future<String> getCurrentUID() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

//  Future<bool> signInWithGoogle() async {
//    final GoogleSignInAccount googleAccount = await _googleSignIn.signIn();
//    if (googleAccount == null) return false;
//    final GoogleSignInAuthentication googleAuth =
//        await googleAccount.authentication;
//    AuthCredential credential = GoogleAuthProvider.getCredential(
//        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
//    try {
//      AuthResult result = await _auth.signInWithCredential(credential);
//      FirebaseUser user = result.user;
//      if (user == null) {
//        return false;
//      } else {
//        dbService.updateUser(
//          user.uid,
//          user.displayName,
//          user.email,
//          user.phoneNumber,
//        ); //for database //TODO:Update this
//        return true;
//      }
//    } catch (e) {
//      return false;
//    }
//  }

  Future<void> signOutGoogle() async {
    try {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
