import 'package:flutter/material.dart';
import 'package:skendy/src/custom_widgets/custom_app_bar.dart';
import 'package:skendy/src/custom_widgets/notification_card.dart';
import 'package:skendy/src/utils/my_colors.dart';
import 'package:skendy/src/utils/my_images.dart';
import 'package:skendy/src/utils/my_strings.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              title: MyStrings.notification,
            ),
            Text(MyStrings.today,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Theme.of(context).focusColor),),
            const SizedBox(
              height: 10,
            ),
            NotificationCard(
              icon: MyImages.notiIcon1,
              text: "",
              time: "2 hr ago",
              boldText: "",
              notificationSeen: false,
            ),
            NotificationCard(
              icon: MyImages.notiIcon2,
              text: "",
              time: "2 hr ago",
              boldText: "",
              notificationSeen: false,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(MyStrings.yesterday,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Theme.of(context).focusColor),),
            const SizedBox(
              height: 10,
            ),
            NotificationCard(
              icon: MyImages.notiIcon3,
              text: "",
              time: "2 hr ago",
              boldText: "",
              notificationSeen: true,
            ),
            NotificationCard(
              icon: MyImages.notiIcon4,
              text: "",
              time: "2 hr ago",
              boldText: "",
              notificationSeen: true,
            ),
            NotificationCard(
              icon: MyImages.notiIcon5,
              text: "",
              time: "2 hr ago",
              boldText: "",
              notificationSeen: true,
            ),
          ],
        ),
      ),
    );
  }
}
