import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {

  final double? height;
  final Widget? child;

  const CustomContainer({Key? key, this.height, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).dividerColor, width: 1.5),
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).cardColor),
      child: child,
    );
  }
}
