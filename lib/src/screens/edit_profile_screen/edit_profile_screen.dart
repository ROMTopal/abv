import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skendy/src/custom_widgets/custom_app_bar.dart';
import 'package:skendy/src/custom_widgets/custom_textfield.dart';
import 'package:skendy/src/database_helper/database_helper.dart';
import 'package:skendy/src/utils/my_colors.dart';
import 'package:skendy/src/utils/my_images.dart';
import 'package:skendy/src/utils/my_strings.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController name= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomAppBar(
              title: MyStrings.editProfile,
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextField(
              hint: "Cameron Williamson",
              prefixIcon: MyImages.profile,
              textInputType: TextInputType.name,
              prefixColor: MyColors.lightOrange,
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextField(
              hint: "(406) 555-0120",
              prefixIcon: MyImages.contactIcon,
              iconClr: MyColors.themeColor,
              textInputType: TextInputType.number,
              prefixColor: MyColors.lightBlue,
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextField(
              hint: "St. Celina, Delaware.",
              prefixIcon: MyImages.locationIcon,
              textInputType: TextInputType.name,
              prefixColor: MyColors.lightOrange,
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(onPressed: (){
              DatabaseHelper.updateUserProfile(FirebaseAuth.instance.currentUser,{});
            }, child: Text("Save",style: TextStyle(fontSize: 16),)),
          ],
        ),
      ),
    );
  }


}
