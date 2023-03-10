import 'package:flutter/material.dart';
import 'package:skendy/src/utils/my_colors.dart';

class IconCard extends StatelessWidget {
  final String? icon;
  final Color? bgColor;
  final Color? iconClr;
  final double? size;
  const IconCard({Key? key, this.icon, this.bgColor, this.size, this.iconClr}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size??40,
        width: size??40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        color: bgColor
    ),
    child: Center(
      child: Image.asset(icon!,height: 20,width: 20,color: iconClr),
    ),
    );
  }
}
