import 'package:flutter/material.dart';
import 'package:skendy/src/utils/my_colors.dart';
import 'package:skendy/src/utils/my_style.dart';

class CustomChips extends StatelessWidget {
  final String? text;
  final VoidCallback? onRemoveClick;

  const CustomChips({Key? key, this.text, this.onRemoveClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 30,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: MyColors.gray),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Row(
                children: [
                   GestureDetector(
                     onTap: onRemoveClick,
                       child: Icon(Icons.close, color: MyColors.grayFont, size: 16)),
                  // ignore: prefer_const_constructors
                  SizedBox(width: 6),
                  Text(text!, style: MyStyles.gray12Light)
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
