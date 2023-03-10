import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skendy/auth_modules/email_pass_auth.dart';
import 'package:skendy/auth_modules/facebook_auth.dart';
import 'package:skendy/auth_modules/google_auth.dart';
import 'package:skendy/src/custom_widgets/custom_app_bar.dart';
import 'package:skendy/src/custom_widgets/custom_container.dart';
import 'package:skendy/src/custom_widgets/icon_card.dart';
import 'package:skendy/src/custom_widgets/proflie_card.dart';
import 'package:skendy/src/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:skendy/src/screens/login_screen/login_screen.dart';
import 'package:skendy/src/utils/my_colors.dart';
import 'package:skendy/src/utils/my_images.dart';
import 'package:skendy/src/utils/my_strings.dart';
import 'package:skendy/src/utils/my_style.dart';

class ProfileScreen extends StatefulWidget {
  final User? user;

  const ProfileScreen({Key? key, this.user}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  goToLoginScreen() {
    Navigator.of(context).popUntil((route) => false);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomAppBar(
              title: MyStrings.profile,
              widget: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfileScreen()));
                },
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfileScreen()));
                  },
                  child: Image.asset(MyImages.renameIcon, color: MyColors.themeColor, height: 22, width: 22, fit: BoxFit.cover),
                ),
              ),
            ),
            Stack(
              children: [
                CustomContainer(
                  height: 208,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        Container(
                          width: 106,
                          height: 106,
                          decoration: BoxDecoration(image: DecorationImage(image: AssetImage(MyImages.roundDottedLine))),
                          child: Center(
                            child: CircleAvatar(
                              radius: 45,
                              backgroundColor: MyColors.lightBlue,
                              child: const Icon(Icons.person, size: 50),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "Cameron Williamson",
                          style: TextStyle(color: Theme.of(context).hintColor, fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          "@william.cameron",
                          style: TextStyle(color: Theme.of(context).focusColor, fontWeight: FontWeight.w400, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 195,
                  top: 88,
                  child: CircleAvatar(
                    backgroundColor: MyColors.themeColor,
                    child: Icon(Icons.camera_alt_outlined, size: 20, color: Theme.of(context).focusColor),
                  ),
                )
              ],
            ),
            const SizedBox(height: 15),
            CustomContainer(
              height: 184,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProfileCard(
                      iconClr: MyColors.themeColor,
                      icon: MyImages.contactIcon,
                      color: MyColors.lightBlue,
                      title: MyStrings.phone,
                      text: "(406) 555-0120",
                    ),
                    ProfileCard(
                      icon: MyImages.emailIcon,
                      color: MyColors.lightGreen,
                      title: MyStrings.email,
                      text: "name@email.com",
                    ),
                    ProfileCard(
                      icon: MyImages.emailIcon,
                      color: MyColors.lightOrange,
                      title: MyStrings.address,
                      text: "St. Celina, Delaware.",
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            CustomContainer(
              height: 128,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProfileCard(
                      iconClr: const Color(0xffFFB703),
                      icon: MyImages.scanDoc,
                      color: MyColors.lightOrange,
                      title: MyStrings.scannedDocuments,
                      text: "32",
                    ),
                    ProfileCard(
                      icon: MyImages.downloadIcon,
                      color: MyColors.lightGreen,
                      title: MyStrings.importDocuments,
                      text: "45",
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                if (widget.user!.providerData.any((element) => element.providerId == 'google.com')) {
                  GoogleAuth.googleLogOut();
                  goToLoginScreen();
                } else if (widget.user!.providerData.any((element) => element.providerId == 'facebook.com')) {
                  FbAuth.facebookLogout();
                  goToLoginScreen();
                } else if (widget.user!.providerData.any((element) => element.providerId == 'password')) {
                  EmailPassAuth.signOut();
                  goToLoginScreen();
                }
              },
              child: CustomContainer(
                height: 72,
                child: Row(
                  children: [
                    const SizedBox(width: 15),
                    IconCard(
                      icon: MyImages.logoutIcon,
                      bgColor: MyColors.lightPink,
                    ),
                    const SizedBox(width: 15),
                    Text(
                      "Log Out",
                      style: MyStyles.black16Normal.copyWith(color: Theme.of(context).hintColor),
                    ),
                    const Spacer(),
                    Container(
                      height: 37,
                      width: 37,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Theme.of(context).buttonColor),
                      child: Center(
                        child: Icon(Icons.arrow_forward_ios, size: 17, color: MyColors.grayFont),
                      ),
                    ),
                    const SizedBox(width: 15),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
