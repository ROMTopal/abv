// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skendy/auth_modules/facebook_auth.dart';
import 'package:skendy/auth_modules/google_auth.dart';
import 'package:skendy/src/screens/home/home.dart';
import 'package:skendy/src/utils/my_images.dart';
import 'package:skendy/src/utils/my_strings.dart';
import 'package:skendy/src/utils/my_style.dart';

class SocialMedia extends StatelessWidget {
  final String? icon;
  final String? text;
  final VoidCallback? onTap;

  const SocialMedia({Key? key, this.icon, this.text, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).cardColor,
                border: Border.all(width: 1.5, color: Theme.of(context).dividerColor)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(icon!, width: 22, height: 22),
                const SizedBox(width: 15),
                Text(text!, style: MyStyles.black16Regular.copyWith(color: Theme.of(context).hintColor))
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class OtherLoginOpt extends StatefulWidget {
  const OtherLoginOpt({Key? key}) : super(key: key);

  @override
  State<OtherLoginOpt> createState() => _OtherLoginOptState();
}

class _OtherLoginOptState extends State<OtherLoginOpt> {
  pushToActionScreen(UserCredential? cred) {
    if (cred != null && cred.user != null) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => Home()), (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SocialMedia(
          text: MyStrings.google,
          onTap: () async {
            UserCredential? cred = await GoogleAuth.googleLogin(context);
            pushToActionScreen(cred);
          },
          icon: MyImages.google,
        ),
        SocialMedia(
          text: MyStrings.linkedIn,
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => Home()),
              (route) => false,
            );
          },
          icon: MyImages.linkedIn,
        ),
        SocialMedia(
          text: MyStrings.twitter,
          onTap: () {},
          icon: MyImages.twitter,
        ),
        SocialMedia(
          text: MyStrings.facebook,
          onTap: () async {
            UserCredential? user = await FbAuth.facebookLogin(context);
            if (user != null) {
              pushToActionScreen(user);
            }
          },
          icon: MyImages.facebook,
        ),
      ],
    );
  }
}
