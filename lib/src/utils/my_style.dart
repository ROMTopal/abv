import 'package:flutter/material.dart';
import 'my_colors.dart';

class MyFontWeight {
  static FontWeight light = FontWeight.w400;
  static FontWeight regular = FontWeight.w500;
  static FontWeight normal = FontWeight.w600;
  static FontWeight semiBold = FontWeight.bold;
  static FontWeight bold = FontWeight.w800;
  static FontWeight extraBold = FontWeight.w900;
}

class MyStyles {
  static TextStyle blue10Normal = TextStyle(fontSize: 10, fontWeight: MyFontWeight.normal,color: MyColors.themeColor);
  static TextStyle blue12Regular = TextStyle(fontSize: 12, fontWeight: MyFontWeight.regular,color: MyColors.themeColor);
  static TextStyle gray12Light = TextStyle(fontSize: 12, fontWeight: MyFontWeight.light,color: MyColors.grayFont);
  static TextStyle blue14Regular = TextStyle(fontSize: 14, fontWeight: MyFontWeight.regular,color: MyColors.themeColor);
  static TextStyle white14Regular = TextStyle(fontSize: 14, fontWeight: MyFontWeight.regular,color: MyColors.white);
  static TextStyle blue14Light = TextStyle(fontSize: 14, fontWeight: MyFontWeight.light,color: MyColors.themeColor);
  static TextStyle black14Light = TextStyle(fontSize: 14, fontWeight: MyFontWeight.light,color: MyColors.black);
  static TextStyle black14Normal = TextStyle(fontSize: 14, fontWeight: MyFontWeight.normal,color: MyColors.black);
  static TextStyle black14Regular = TextStyle(fontSize: 14, fontWeight: MyFontWeight.regular,color: MyColors.black);
  static TextStyle blue16Normal = TextStyle(fontSize: 16, fontWeight: MyFontWeight.normal,color: MyColors.themeColor);
  static TextStyle black16Regular = TextStyle(fontSize: 16, fontWeight: MyFontWeight.regular,color: MyColors.black);
  static TextStyle black16Normal = TextStyle(fontSize: 16, fontWeight: MyFontWeight.normal,color: MyColors.black);
  static TextStyle gray16Light = TextStyle(fontSize: 16, fontWeight: MyFontWeight.light,color: MyColors.grayFont);
  static TextStyle white16Normal = TextStyle(fontSize: 16, fontWeight: MyFontWeight.normal,color: MyColors.white);
  static TextStyle white16regular = TextStyle(fontSize: 16, fontWeight: MyFontWeight.regular,color: MyColors.white);
  static TextStyle gray16regular = TextStyle(fontSize: 16, fontWeight: MyFontWeight.regular,color: MyColors.grayFont);
  static TextStyle black18Normal = TextStyle(fontSize: 18, fontWeight: MyFontWeight.normal,color: MyColors.black);
  static TextStyle white20Normal = TextStyle(fontSize: 20, fontWeight: MyFontWeight.normal,color: MyColors.white);
  static TextStyle black20Normal = TextStyle(fontSize: 20, fontWeight: MyFontWeight.normal,color: MyColors.black);
}