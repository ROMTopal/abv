import 'dart:ui';

import 'package:skendy/src/utils/my_images.dart';

class CustomCategory {
  final bool? delete;
  final List<dynamic>? keywords;
  final String name;
  String iconName;
  final Color? bgColor;
  bool? isSelected;

  CustomCategory({
    this.delete,
    this.keywords,
    required this.name,
    this.iconName = MyImages.businessIcon,
    this.bgColor,
    this.isSelected = false,
  });

  factory CustomCategory.fromMap(Map<String, dynamic> map) {
    return CustomCategory(
      delete: map['delete'] as bool,
      keywords: map['keywords'] as List<dynamic>,
      name: map['name'] as String,
      iconName: map['iconName'] as String,
    );
  }
}
