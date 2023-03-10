import 'package:flutter/material.dart';
import 'package:skendy/src/utils/my_colors.dart';
import 'package:skendy/src/utils/my_style.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onTap;
  final bool? border;

  const CustomButton({Key? key, this.text, this.onTap, this.border})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
            color: border == true ? MyColors.themeColor : MyColors.white,
            border: Border.all(
                color: border == true ? Theme.of(context).dividerColor : MyColors.transparent),
            borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Text(text!,
              style: border == true
                  ? MyStyles.white16Normal
                  : MyStyles.blue16Normal),
        ),
      ),
    );
  }
}

class CustomButtonWithIcon extends StatelessWidget {
  final String? text;
  final String? icon;
  final VoidCallback? onTap;
  final bool? border;

  const CustomButtonWithIcon({Key? key, this.text, this.onTap, this.border, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
            color: border == true ? MyColors.themeColor : MyColors.white,
            border: Border.all(
                color: border == true ? Theme.of(context).dividerColor : MyColors.transparent),
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Row(
              children: [
                Image.asset(icon!,height: 20,width: 20,color: border == true ? MyColors.white : MyColors.themeColor,),
                const SizedBox(width: 9),
                Text(text!,
                    style: border == true
                        ? MyStyles.white16Normal
                        : MyStyles.blue16Normal),
              ],
            ),
          ),
        ),
      ),
    );
  }
}