import 'package:flutter/material.dart';

snackBar(context,String content, {Duration? duration}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: duration??const Duration(seconds: 3),
    content: Text(content),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
      },
    ),
  ));
  
}
