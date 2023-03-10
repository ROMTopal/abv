import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:skendy/src/custom_widgets/snackbar.dart';
import 'package:skendy/src/database_helper/database_helper.dart';
import 'package:skendy/src/utils/my_strings.dart';
import 'package:googleapis/drive/v3.dart' as ga;
class GoogleAuth {
  static GoogleSignIn googleSignIn = GoogleSignIn.standard(scopes: [ga.DriveApi.driveFileScope]);
  // static final FirebaseAuth _auth = FirebaseAuth.instance;

  // static bool signedIn = false;
  // static final storage =  FlutterSecureStorage();
  // static GoogleSignInAccount? googleSignInAccount;

  // static Future<UserCredential?> loginWithGoogle() async {
  //   try{
  //     print("loginWithGoogle called");
  //     signedIn = await storage.read(key: "signedIn") == "true" ? true : false;
  //     print("loginWithGoogle called 2");
  //
  //     googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? googleSignInAccount) async {
  //       print('QQQQQQQQQQQQQ');
  //       if (googleSignInAccount != null) {
  //         print("WOWOW");
  //         afterGoogleLogin(googleSignInAccount);
  //       }
  //     });
  //     print("loginWithGoogle $signedIn");
  //     if (signedIn) {
  //       try {
  //         print("Try to sign in");
  //         googleSignIn.signInSilently().whenComplete(() => () {
  //           print("Complete");
  //           return afterGoogleLogin(googleSignInAccount!);
  //
  //         });
  //         print("Complete 2");
  //       } catch (e) {
  //         storage.write(key: "signedIn", value: "false").then((value) {
  //           signedIn = false;
  //         });
  //       }
  //     } else {
  //       print("WWWW");
  //       final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  //       return afterGoogleLogin(googleSignInAccount!);
  //     }
  //   }catch (e){
  //     print("loginWithGoogle error $e");
  //   }
  // }
  //
  // static Future<UserCredential?> afterGoogleLogin(GoogleSignInAccount gSA) async {
  //   googleSignInAccount = gSA;
  //   final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
  //
  //   final AuthCredential credential = GoogleAuthProvider.credential(
  //     accessToken: googleSignInAuthentication.accessToken,
  //     idToken: googleSignInAuthentication.idToken,
  //   );
  //
  //   final UserCredential authResult = await _auth.signInWithCredential(credential);
  //   final User? user = authResult.user;
  //
  //   assert(!user!.isAnonymous);
  //
  //   final User currentUser = _auth.currentUser!;
  //   assert(user!.uid == currentUser.uid);
  //
  //   print('signInWithGoogle succeeded: $user');
  //
  //   storage.write(key: "signedIn", value: "true").then((value) {
  //
  //       signedIn = true;
  //
  //   });
  //   return authResult;
  // }

  static Future<UserCredential?>? googleLogin(context) async {
    try {
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      OAuthCredential credential = GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      UserCredential user =await  FirebaseAuth.instance.signInWithCredential(credential);
      DatabaseHelper.addUserToFirestore(user.user!);
      return FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == "network-request-failed") {
        snackBar(context,MyStrings.pleaseCheckInternet);
      } else if (e.code == 'weak-password') {
        snackBar(context,MyStrings.thisPasswordIsWeak);
      } else if (e.code == 'email-already-in-use') {
        snackBar(context,MyStrings.theAccountAlreadyExists);
      } else {
        snackBar(context,e.toString());
      }
      return null;
    } on PlatformException catch (e) {
      if (e.code == "network_error") {
        snackBar(context,MyStrings.pleaseCheckInternet);
      } else {
        snackBar(context,e.toString());
      }
      return null;
    }
  }

  static Future<void> googleLogOut() async {
    FirebaseAuth.instance.signOut();
    await googleSignIn.signOut();
  }
}
