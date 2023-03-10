import 'package:flutter/material.dart';
import 'package:skendy/src/custom_widgets/custom_card.dart';
import 'package:skendy/src/custom_widgets/custom_app_bar.dart';
import 'package:skendy/src/screens/choose_category_screen/choose_category_screen.dart';
import 'package:skendy/src/screens/cloud_screen/cloud_screen.dart';
import 'package:skendy/src/screens/connect_drive_screen/connect_drive_screen.dart';
import 'package:skendy/src/screens/contact_us_screen/contact_us_screen.dart';
import 'package:skendy/src/screens/general_screen/general_screen.dart';
import 'package:skendy/src/screens/notification_screen/notification_screen.dart';
import 'package:skendy/src/screens/theme_screen/theme_screen.dart';
import 'package:skendy/src/utils/my_colors.dart';
import 'package:skendy/src/utils/my_images.dart';
import 'package:skendy/src/utils/my_strings.dart';

class SettingsScreen extends StatefulWidget {
  const
  SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomAppBar(
              title: MyStrings.settings,
            ),
            CustomCard(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>const ThemeScreen()),);
              },
              color: MyColors.lightBlue,
              icon: MyImages.themeIcon,
              text: MyStrings.theme,
              arrowIcon: true,
            ),
            CustomCard(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>const GeneralScreen()),);
              },
              color: MyColors.lightPink,
              icon: MyImages.generalIcon,
              text: MyStrings.general,
              arrowIcon: true,
            ),
            CustomCard(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>const ConnectDriveScreen()),);
              },
              color: MyColors.lightGreen,
              icon: MyImages.connectDriveIcon,
              text: MyStrings.connectDrive,
              arrowIcon: true,
            ),
            CustomCard(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>const NotificationScreen()));
              },
              color: MyColors.lightOrange,
              icon: MyImages.notificationIcon,
              text: MyStrings.notification,
              arrowIcon: true,
            ),
            CustomCard(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>const CloudScreen()),);
              },
              color: MyColors.lightPink,
              icon: MyImages.categoryIcon,
              text: MyStrings.category,
              arrowIcon: true,
            ),
            CustomCard(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>const ContactUsScreen()),);
              },
              color: MyColors.lightGreen,
              icon: MyImages.contactIcon,
              text: MyStrings.contact,
              arrowIcon: true,
            ),
            CustomCard(
              onTap: (){},
              color: MyColors.lightOrange,
              icon: MyImages.rateIcon,
              text: MyStrings.rateTheApp,
              arrowIcon: true,
            ),
          ],
        ),
      ),
    );
  }
}
