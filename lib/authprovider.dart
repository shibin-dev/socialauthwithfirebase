import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider with ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  final firebase = FirebaseAuth.instance;
  GoogleSignInAccount? user;

  Future googleLogin() async {
    try {
      final loggedUser = await googleSignIn.signIn();
      if (loggedUser == null) return;
      user = loggedUser;
      final auth = await loggedUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: auth.accessToken,
        idToken: auth.idToken,
      );
      await firebase.signInWithCredential(credential);
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future googleLogout() async {
    await googleSignIn.disconnect();
    firebase.signOut();
  }
}
