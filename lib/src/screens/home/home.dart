// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skendy/src/custom_widgets/custom_button.dart';
import 'package:skendy/src/screens/camera_screen/camera_screen.dart';
import 'package:skendy/src/screens/profile_Screen/profile_Screen.dart';
import 'package:skendy/src/screens/settings_screen/settings_screen.dart';
import 'package:skendy/src/screens/upcoming_action/upcoming_action.dart';
import 'package:skendy/src/utils/my_colors.dart';
import 'package:skendy/src/utils/my_strings.dart';
import '../../utils/my_images.dart';
import '../../utils/my_style.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? user;

  getUser() {
    user = firebaseAuth.currentUser;

    setState(() {});
  }

  navigateToProfileScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen(user: user)));
  }

  navigateToSettingScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
  }

  navigateToUpcomingAction() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => UpcomingActions()));
  }

  navigateToCameraScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const CameraScreen()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: [
              Row(
                children: [
                  if (user == null || user!.photoURL == null)
                    GestureDetector(
                      onTap: () {
                        navigateToProfileScreen();
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: MyColors.lightPink,
                        ),
                        child: Center(
                          child: Image.asset(MyImages.profile),
                        ),
                      ),
                    )
                  else
                    GestureDetector(
                      onTap: () {
                        navigateToProfileScreen();
                      },
                      child: CircleAvatar(
                        minRadius: 15,
                        maxRadius: 20,
                        backgroundImage: NetworkImage(user!.photoURL!),
                      ),
                    ),
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Good Morning", style: MyStyles.gray16regular),
                      const SizedBox(height: 6),
                      Text("${user!.displayName}", style: MyStyles.black16Normal),
                    ],
                  ),
                  const Spacer(),
                  Image.asset(MyImages.import, height: 32, width: 32),
                  const SizedBox(width: 12),
                  GestureDetector(
                      onTap: () {
                        navigateToSettingScreen();
                      },
                      child: Image.asset(MyImages.settingsIcon, height: 32, width: 32))
                ],
              ),
              const SizedBox(height: 48),
              GestureDetector(
                onTap: () {
                  navigateToUpcomingAction();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 96,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: const Color(0xffEE913B)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(MyImages.info, height: 40, width: 40),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Upcoming Action", style: MyStyles.white16Normal),
                              const SizedBox(height: 8),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(text: 'You have to ', style: MyStyles.white14Regular),
                                    TextSpan(
                                      text: 'PAY \$15 ',
                                      style: MyStyles.white14Regular.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(text: 'before ', style: MyStyles.white14Regular),
                                    TextSpan(
                                      text: '05 FEB',
                                      style: MyStyles.white14Regular.copyWith(fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Image.asset(MyImages.forward, height: 40, width: 40),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(0.4)), borderRadius: BorderRadius.circular(12), color: CupertinoColors.white),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Column(
                    children: [
                      Row(children: [
                        Image.asset(MyImages.scan, height: 28, width: 28),
                        const SizedBox(width: 10),
                        Expanded(child: Text(MyStrings.scannedDocuments, style: MyStyles.black14Regular.copyWith(fontWeight: FontWeight.w600))),
                        Image.asset(MyImages.forwardGrey, height: 30, width: 30),
                      ]),
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (c, i) {
                              return ScannedDocumentTile();
                            }),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  SaveTimeTile(title: MyStrings.savedTime, icon: MyImages.savedTime, desc: "133 Min"),
                  SizedBox(width: 16),
                  SaveTimeTile(title: MyStrings.scannedDoc, icon: MyImages.scannedGreen, desc: "35"),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButtonWithIcon(icon: MyImages.scanTransparent, onTap: () {
                    navigateToCameraScreen();
                  }, border: true, text: MyStrings.scannedDocuments),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SaveTimeTile extends StatelessWidget {
  final String icon;
  final String title;
  final String desc;

  const SaveTimeTile({Key? key, required this.icon, required this.title, required this.desc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 160,
        height: 77,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.4)), borderRadius: BorderRadius.circular(12), color: CupertinoColors.white),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(icon, height: 28, width: 28),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: MyStyles.gray12Light.copyWith(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  SizedBox(height: 6),
                  Text(
                    desc,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScannedDocumentTile extends StatelessWidget {
  const ScannedDocumentTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: const Color(0xffF9FBFF)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          child: Row(children: [
            Image.asset(MyImages.pdfIcon, height: 50, width: 50),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Anna's Documents.pdf", style: MyStyles.black16Normal),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text("2.9 MB", style: MyStyles.gray12Light),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: MyColors.grayFont),
                        ),
                      ),
                      Text("01 Feb", style: MyStyles.gray12Light),
                    ],
                  ),
                ],
              ),
            ),
            GestureDetector(
                onTap: () {
                  print("PRE");
                },
                child: Icon(
                  Icons.more_vert,
                  size: 25,
                  color: MyColors.grayFont,
                ))
          ]),
        ),
      ),
    );
  }
}
