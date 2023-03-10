import 'package:flutter/material.dart';
import 'package:skendy/src/custom_widgets/icon_card.dart';
import 'package:skendy/src/utils/my_images.dart';
import 'package:skendy/src/utils/my_style.dart';

class ScanDocRow extends StatelessWidget {
  final String? icon;
  final String? text;
  final Color? color;
  final VoidCallback? onTap;
  final bool? divider;

  const ScanDocRow(
      {Key? key, this.icon, this.text, this.color, this.onTap, this.divider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                IconCard(
                  size: 50,
                  icon: icon,
                  bgColor: color,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  text!,
                  style: MyStyles.black16Regular.copyWith(
                    color: Theme.of(context).hintColor,

                  ),
                ),
                const Spacer(),
                Image.asset(
                  MyImages.editIcon,
                  height: 24,
                  width: 24,
                  color: Theme.of(context).canvasColor,
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        divider==true?Column(
          children: [
            Divider(
              color: Theme.of(context).dividerColor,
              thickness: 1.5,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ):Container(),
      ],
    );
  }
}
