// ignore_for_file: use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skendy/src/custom_widgets/snackbar.dart';
import 'package:skendy/src/database_helper/database_helper.dart';
import 'package:skendy/src/utils/my_strings.dart';

class EmailPassAuth {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static Future<UserCredential?> signInUser(String email, String pass, context) async {
    try {
      print('QQQ');
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: pass);
      print('user $userCredential');
      return userCredential;
    } catch (e) {
      snackBar(context,getLoginMessageFromErrorCode(e.toString()));

      return null;
    }
  }

  static sendVerification() async {
    await auth.currentUser!.sendEmailVerification();
  }

  static Future<User?> createUserWithEmailPass(String email, String pass, BuildContext context) async {
    print("createUserWithEmailPass called");
    try {
      print('$email $pass');
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: pass);
      print("createUserWithEmailPass :: $userCredential");
      await sendVerification();
      snackBar(context,MyStrings.verifyEmailMyClicking);
      print("adding user to firebase");
      await DatabaseHelper.addUserToFirestore(userCredential.user!);
      print("User added to firebase");
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print("ERROR");
      print(e.code);
      if (e.code == "network-request-failed") {
        snackBar(context,MyStrings.pleaseCheckInternet);
      } else if (e.code == 'weak-password') {
        snackBar(context,MyStrings.thisPasswordIsWeak);
      } else if (e.code == 'email-already-in-use') {
        snackBar(context,MyStrings.theAccountAlreadyExists);
      }
      return null;
    } catch (e) {
      print("ERROR");
      debugPrint(e.toString());
      return null;
    }

  }

  static Future<void> resetPassword(String email, context, VoidCallback onMailSent) async {
    try {
      print("WWWWWWWWWWWWWWW");
      await auth.sendPasswordResetEmail(email: email).then((value) {
        onMailSent();
        print("MMMMMMMMMMMMMMM");
      });

    } catch (e) {
      snackBar(context,getLoginMessageFromErrorCode(e.toString()));
    }
  }

  static Future<void> signOut() async {
    auth.signOut();
  }
}

String getLoginMessageFromErrorCode(String errorCode) {
  if (errorCode.contains("ERROR_EMAIL_ALREADY_IN_USE") ||
      errorCode.contains("account-exists-with-different-credential") ||
      errorCode.contains("email-already-in-use")) {
    return "Email already in use. Try a different one.";
  } else if (errorCode.contains("account-exists-with-different-credential")) {
    return "Account exists with different provider";
  } else if (errorCode.contains("ERROR_WRONG_PASSWORD") || errorCode.contains("wrong-password")) {
    return "Wrong email/password combination.";
  } else if (errorCode.contains("ERROR_USER_NOT_FOUND") || errorCode.contains("wrong-found") || errorCode.contains("user-not-found")) {
    return "No user found with this email account.";
  } else if (errorCode.contains("ERROR_USER_DISABLED") || errorCode.contains("user-disabled")) {
    return "User disabled.";
  } else if (errorCode.contains("ERROR_TOO_MANY_REQUESTS") || errorCode.contains("too-many-requests")) {
    return "Too many requests to sign into this account.";
  } else if (errorCode.contains("ERROR_OPERATION_NOT_ALLOWED") || errorCode.contains("operation-not-allowed")) {
    return "Server error. Please try again later.";
  } else if (errorCode.contains("ERROR_INVALID_EMAIL") || errorCode.contains("invalid-email")) {
    return "Email address is invalid.";
  } else if (errorCode.contains("weak-password")) {
    return "Password should be at least 6 characters";
  }

  return "Login failed. Please try again.";
}
