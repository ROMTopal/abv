import 'package:flutter/material.dart';
import 'package:skendy/src/utils/my_colors.dart';
import 'package:skendy/src/utils/my_style.dart';

class SwitchCard extends StatelessWidget {

  final String? text;
  final Function(bool)? onTap;
  final bool? value;


  const SwitchCard({Key? key, this.text, this.onTap,  this.value,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 72,
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border.all(width: 1.5, color: Theme.of(context).dividerColor),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Text(text!,style: MyStyles.black16Normal.copyWith(
                  color: Theme.of(context).hintColor
                ),),
                const Spacer(),
                Switch(value: value!, onChanged: onTap,activeColor: MyColors.white,activeTrackColor: MyColors.themeColor,)
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
