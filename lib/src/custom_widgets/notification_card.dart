import 'package:flutter/material.dart';
import 'package:skendy/src/utils/my_colors.dart';

class NotificationCard extends StatelessWidget {

  final String? icon;
  final String? time;
  final String? text;
  final String? boldText;
  final bool? notificationSeen;

  const NotificationCard({Key? key, this.icon, this.time, this.text, this.boldText, this.notificationSeen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 104,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: notificationSeen==true?Theme.of(context).cardColor:Theme.of(context).indicatorColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 17),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(icon!,height: 28,width: 28,),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: "Documents",
                          style: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 16
                          ),
                          children: [
                            TextSpan(text: " imported successful,",style: TextStyle(
                                color: Theme.of(context).hintColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16
                            )),
                            TextSpan(
                                text: "\nNow you can make change on it.",style: TextStyle(
                              height: 1.4,
                                color: Theme.of(context).hintColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 16
                            )),
                          ]
                        ),
                      ),
                    ),
                    Text(time!,style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).hintColor
                    ),)
                  ],
                ),
                const Spacer(),
                notificationSeen==true?const SizedBox():CircleAvatar(
                  backgroundColor: MyColors.themeColor,
                  radius: 5,
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
