import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:study_sync/utils/utils.dart';

class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  Stream<User?> get authchanges => _auth.authStateChanges();
  User get user => _auth.currentUser!;

  Future<bool> signInWithGoogle(BuildContext context) async {
    bool result = false;
    try {
      final GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleuser?.authentication;

      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credentials);

      User? user = userCredential.user;

      if (user != null){
        if (userCredential.additionalUserInfo!.isNewUser){
          await _firebase.collection('user').doc(user.uid).set({
            'username' : user.displayName,
            'uid' : user.uid,
            'profilePicture' : user.photoURL,
        });
        }
      }

      result = true;

    } on FirebaseAuthException catch(e) {
      showSnackBar(context, e.message!);
      result = false;
    }

    return result;
  }

  void signOut() async {
    try {
      _auth.signOut();
    } catch (e) {
      print(e);
    }
  }

}