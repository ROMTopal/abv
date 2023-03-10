import 'package:flutter/material.dart';

class ShowLoader extends StatelessWidget {
  const ShowLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}

showLoading(context) async {
  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return ShowLoader();
      });
}
