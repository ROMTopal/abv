import 'package:flutter/material.dart';
import 'package:skendy/src/custom_widgets/icon_card.dart';
import 'package:skendy/src/utils/my_colors.dart';
import 'package:skendy/src/utils/my_images.dart';
import 'package:skendy/src/utils/my_strings.dart';
import 'package:skendy/src/utils/my_style.dart';

class CustomCard extends StatelessWidget {
  final Color? color;
  final String? icon;
  final String? text;
  final bool? arrowIcon;
  final VoidCallback? onTap;

  const CustomCard({Key? key, this.color, this.icon, this.text, this.onTap, this.arrowIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            height: 72,
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border.all(width: 1.5, color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                const SizedBox(
                  width: 15,
                ),
                IconCard(
                  icon: icon,
                  bgColor: color??const Color(0xffFBFBFB),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  text!,
                  style: MyStyles.black16Normal.copyWith(
                      color: Theme.of(context).hintColor
                  ),
                ),
                const Spacer(),
                Container(
                  height: 37,
                  width: 37,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).buttonColor),
                  child:  Center(
                    child: arrowIcon==true? Icon(Icons.arrow_forward_ios,size: 17,color: MyColors.grayFont,):Image.asset(MyImages.tickIcon),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
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
