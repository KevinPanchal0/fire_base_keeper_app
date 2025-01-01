import 'package:fire_base_keeper_app/utils/prefs/auth_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FbAuthHelper {
  FbAuthHelper._();
  static final FbAuthHelper fbAuthHelper = FbAuthHelper._();

  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> signIn(
      {required String email, required String password}) async {
    String errorMessage;
    Map<String, dynamic> res = {};

    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      res['user'] = user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'The email address is badly formatted.';
          break;
        case 'user-disabled':
          errorMessage =
              'The user account has been disabled by an administrator.';
          break;
        case 'user-not-found':
          errorMessage = 'No user found with this email. Please sign up first.';
          break;
        case 'wrong-password':
          errorMessage = 'The password is invalid for the given email.';
          break;
        case 'network-request-failed':
          errorMessage = 'A network error occurred. Please try again later.';
          break;
        case 'too-many-requests':
          errorMessage =
              'Too many unsuccessful login attempts. Please try again later.';
          break;
        default:
          errorMessage = 'An unknown error occurred: ${e.message}';
      }
      res['error'] = errorMessage;
    }
    return res;
  }

  Future<Map<String, dynamic>> signUp(
      {required String email, required String password}) async {
    String message;
    Map<String, dynamic> res = {};
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      res['user'] = user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          message = 'The email address is not valid.';
          break;
        case 'user-disabled':
          message = 'This user has been disabled.';
          break;
        case 'user-not-found':
          message = 'No user found with this email.';
          break;
        case 'wrong-password':
          message = 'The password is incorrect.';
          break;
        case 'email-already-in-use':
          message = 'The email address is already in use.';
          break;
        case 'weak-password':
          message = 'The password is too weak.';
          break;
        case 'operation-not-allowed':
          message =
              'This operation is not allowed. Please enable it in the Firebase Console.';
          break;
        default:
          message = 'An unknown error occurred: ${e.message}';
      }

      res['error'] = message;
    }

    return res;
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut(); // Sign out from Firebase
    await AuthPreferences.clearLoginState(); // Clear login state

    // Navigate to the login screen
    Navigator.pushReplacementNamed(context, 'sign_in_page');
  }
}
