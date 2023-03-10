import 'package:flutter/material.dart';
import 'package:skendy/src/custom_widgets/custom_card.dart';
import 'package:skendy/src/custom_widgets/custom_app_bar.dart';
import 'package:skendy/src/screens/cloud_screen/cloud_screen.dart';
import 'package:skendy/src/utils/my_colors.dart';
import 'package:skendy/src/utils/my_images.dart';
import 'package:skendy/src/utils/my_strings.dart';
import 'package:skendy/src/utils/my_style.dart';

class ConnectDriveScreen extends StatefulWidget {
  const ConnectDriveScreen({Key? key}) : super(key: key);

  @override
  State<ConnectDriveScreen> createState() => _ConnectDriveScreenState();
}

class _ConnectDriveScreenState extends State<ConnectDriveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              title: MyStrings.connectDrive,
            ),
            Text(MyStrings.chooseCloud, style: MyStyles.black20Normal.copyWith(
              color: Theme.of(context).hintColor
            )),
            const SizedBox(
              height: 20,
            ),
            CustomCard(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_)=>const CloudScreen()),);
              },
              icon: MyImages.google,
              text: MyStrings.google,
              arrowIcon: true,
            ),
            CustomCard(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_)=>const CloudScreen()),);
              },
              icon: MyImages.dropboxIcon,
              text: MyStrings.dropbox,
              arrowIcon: true,
            ),
            CustomCard(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_)=>const CloudScreen()),);
              },
              icon: MyImages.microsoftIcon,
              text: MyStrings.microsoft,
              arrowIcon: true,
            ),
            CustomCard(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_)=>const CloudScreen()),);
              },
              icon: MyImages.cloudICon,
              text: MyStrings.iCloud,
              arrowIcon: true,
            ),
            CustomCard(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_)=>const CloudScreen()),);
              },
              icon: MyImages.localIcon,
              text: MyStrings.local,
              arrowIcon: true,
            ),
          ],
        ),
      ),
    );
  }
}
