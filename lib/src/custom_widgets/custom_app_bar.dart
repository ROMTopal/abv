import 'package:flutter/material.dart';
import 'package:skendy/src/utils/my_colors.dart';
import 'package:skendy/src/utils/my_images.dart';
import 'package:skendy/src/utils/my_style.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  final Widget? widget;

  const CustomAppBar({Key? key, this.title, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  MyImages.backIcon,
                  color: Theme.of(context).hintColor,
                )),
            Text(title ?? "", style: MyStyles.black18Normal.copyWith(color: Theme.of(context).hintColor)),
            widget ??
                Image.asset(
                  MyImages.backIcon,
                  color: MyColors.transparent,
                ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
