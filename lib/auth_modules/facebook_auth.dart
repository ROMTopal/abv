import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:skendy/auth_modules/email_pass_auth.dart';
import 'package:skendy/src/custom_widgets/snackbar.dart';

class FbAuth {
  static final fbSignIn = FacebookAuth.instance;
  static Future<UserCredential?> facebookLogin(context) async {
    try{
      LoginResult log = await fbSignIn.login();
      OAuthCredential cre = FacebookAuthProvider.credential(log.accessToken!.token);
      print("QQQQQQQQQQQQQQ ::: $cre");
      return FirebaseAuth.instance.signInWithCredential(cre);
    }catch(e) {
      snackBar(context,getLoginMessageFromErrorCode(e.toString()));
      return null;
    }

  }

  static Future<void> facebookLogout() async {
    fbSignIn.logOut();
  }
}



