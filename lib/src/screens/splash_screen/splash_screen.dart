import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skendy/src/screens/home/home.dart';
import 'package:skendy/src/screens/splash_screen2/splash_screen2.dart';
import 'package:skendy/src/utils/my_colors.dart';
import 'package:skendy/src/utils/my_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  Timer? timer;

  navigateToScreen() {
    user = auth.currentUser;
    Timer(const Duration(seconds: 2), () {
      if(user !=null && user!.emailVerified) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SplashScreen2()));


      }
    });
  }

  @override
  void initState() {
    super.initState();
    navigateToScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.themeColor,
      body: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(MyImages.bgLeft),
              ],
            ),
          ),
          Image.asset(MyImages.whiteLogo, width: 186, height: 49),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(MyImages.bgRight, width: 132, height: 518),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
