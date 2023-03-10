import 'package:flutter/material.dart';
import 'package:skendy/src/custom_widgets/icon_card.dart';
import 'package:skendy/src/utils/my_style.dart';

class ProfileCard extends StatelessWidget {

  final String? icon;
  final Color? color;
  final Color? iconClr;
  final String? text;
  final String? title;

  const ProfileCard({Key? key, this.icon, this.color, this.text, this.title, this.iconClr}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconCard(
          icon: icon,
          bgColor: color,
          iconClr: iconClr,
        ),
        const SizedBox(
          width: 7,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title!,style: MyStyles.gray16Light.copyWith(
              fontSize: 14,
              color: Theme.of(context).focusColor
            ),),
            const SizedBox(
              height: 2,
            ),
            Text(text!,style: MyStyles.black16Normal.copyWith(
                color: Theme.of(context).hintColor
            ),)
          ],
        )
      ],
    );
  }
}
