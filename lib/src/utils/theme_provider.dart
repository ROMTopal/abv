import 'package:flutter/material.dart';
import 'package:skendy/src/utils/my_colors.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
      fontFamily: 'THICCCBOI',

      // scaffold bg color
      scaffoldBackgroundColor: MyColors.darkBg,

      //textField and social media card color
      cardColor: MyColors.textFieldDarkBg,

      //textField and social media card border color
      dividerColor: MyColors.textFieldDarkBorder,

      //icon bg color
      buttonColor: MyColors.iconDarkBg,

      //text color
      hintColor: MyColors.white,
      accentColor: MyColors.darkBg,
      canvasColor: MyColors.darkIconClr,
      hoverColor: const Color(0xff0096C7).withOpacity(0.2),

      // for gray text
      focusColor: const Color(0xffD4D4D8),

      //unseen notification card
      indicatorColor: const Color(0xff1D2335),

      //splash screen2 side img
      primaryColor: MyColors.darkSide,

      //splash screen2 buttons
      backgroundColor: MyColors.themeColor,

      //splash screen2 buttons text
      highlightColor: MyColors.white,

      //splash screen2 scaffold clr
      splashColor: MyColors.darkBg,
      colorScheme: const ColorScheme.dark());

  static final lightTheme = ThemeData(
      buttonTheme: const ButtonThemeData(buttonColor: MyColors.themeColor),
      fontFamily: 'THICCCBOI',

      // scaffold bg color
      scaffoldBackgroundColor: MyColors.whiteBg,

      //textField and social media card color
      cardColor: MyColors.white,

      //textField and social media card border color
      dividerColor: MyColors.borderClr,

      //icon bg color
      buttonColor: MyColors.grayCont,

      //text color
      hintColor: MyColors.black,
      accentColor: MyColors.themeColor,

      //edit icon color
      canvasColor: MyColors.grayFont,
      hoverColor: const Color(0xffEAF3FB),

      // for gray text
      focusColor: const Color(0xff6E6E6E),

      //unseen notification card
      indicatorColor: MyColors.notificationLight,

      //splash screen2 side img
      primaryColor: MyColors.lightSide,

      //splash screen2 buttons
      backgroundColor: MyColors.white,

      //splash screen2 buttons text
      highlightColor: MyColors.themeColor,

      //splash screen2 scaffold clr
      splashColor: MyColors.themeColor,
      colorScheme: const ColorScheme.light());
}
