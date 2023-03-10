// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skendy/src/custom_widgets/custom_card.dart';
import 'package:skendy/src/custom_widgets/snackbar.dart';
import 'package:skendy/src/screens/camera_screen/camera_screen.dart';
import 'package:skendy/src/screens/profile_Screen/profile_Screen.dart';
import 'package:skendy/src/screens/recently_scan/recently_scan.dart';
import 'package:skendy/src/screens/settings_screen/settings_screen.dart';
import 'package:skendy/src/utils/my_colors.dart';
import 'package:skendy/src/utils/my_images.dart';
import 'package:skendy/src/utils/my_strings.dart';
import 'package:skendy/src/utils/my_style.dart';

class ActionScreen extends StatefulWidget {
  const ActionScreen({Key? key}) : super(key: key);

  @override
  State<ActionScreen> createState() => _ActionScreenState();
}

class _ActionScreenState extends State<ActionScreen> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? user;

  importFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'jpeg', 'png', 'docx'],
    );
    if (result != null) {
      // File file = File(result.files.single.path!);
      snackBar(context, MyStrings.fileImportedSuccessfully);
    } else {
      snackBar(context, MyStrings.pleaseSelectFile);
    }
  }

  getUser() {
    user = firebaseAuth.currentUser;

    setState(() {});
  }

  navigateToProfileScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen(user: user)));
  }

  @override
  void initState() {
    // TODO: implement initState
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(MyStrings.goodMorning, style: MyStyles.gray16Light),
                    const SizedBox(height: 7),
                    Text(
                      MyStrings.ralphEdwards,
                      style: MyStyles.black20Normal.copyWith(color: Theme.of(context).hintColor),
                    ),
                  ],
                ),
                const Spacer(),
                if (user == null || user!.photoURL == null)
                  GestureDetector(
                    onTap: () {
                      navigateToProfileScreen();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: MyColors.lightPink),
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
              ],
            ),
            const SizedBox(height: 25),
            Text(MyStrings.letsWork, style: MyStyles.black20Normal.copyWith(color: Theme.of(context).hintColor)),
            const SizedBox(height: 20),
            CustomCard(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RecentlyScan()),
                );
              },
              icon: MyImages.scanDoc,
              text: MyStrings.scannedDocuments,
              arrowIcon: true,
              color: MyColors.lightBlue,
            ),
            CustomCard(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CameraScreen()),
                );
              },
              icon: MyImages.newDoc,
              text: MyStrings.newDocuments,
              arrowIcon: true,
              color: MyColors.lightPink,
            ),
            CustomCard(
              onTap: () {
                importFile();
              },
              icon: MyImages.importDoc,
              text: MyStrings.importDocuments,
              arrowIcon: true,
              color: MyColors.lightGreen,
            ),
            CustomCard(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                );
              },
              icon: MyImages.settingsIcon,
              text: MyStrings.settings,
              arrowIcon: true,
              color: MyColors.lightOrange,
            ),
          ],
        ),
      ),
    );
  }
}
