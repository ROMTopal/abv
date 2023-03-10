import 'package:flutter/material.dart';
import 'package:skendy/models/custom_category_model.dart';
import 'package:skendy/models/custom_category_model.dart';
import 'package:skendy/models/custom_category_model.dart';
import 'package:skendy/src/custom_widgets/icon_card.dart';
import 'package:skendy/src/utils/global.dart';
import 'package:skendy/src/utils/my_colors.dart';
import 'package:skendy/src/utils/my_images.dart';
import 'package:skendy/src/utils/my_style.dart';

class CategoryCard extends StatelessWidget {
  CustomCategory? category;
  final IconModel? iconModel;
  final Function(bool)? onSelect;

  CategoryCard({
    Key? key,
    this.category,
    this.onSelect,
    this.iconModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            onSelect!(!category!.isSelected!);
          },
          child: Container(
            width: double.infinity,
            height: 72,
            decoration: BoxDecoration(
                color: category!.isSelected! ? MyColors.themeColor : Theme.of(context).cardColor,
                border: Border.all(width: 1.5, color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                const SizedBox(width: 15),
                if(iconModel !=null)
                  iconModel!.icon
                  else
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: category!.isSelected! ? MyColors.white : category!.bgColor),
                  child: Center(
                    child: Image.asset(category!.iconName, height: 20, width: 20, color: category!.isSelected! ? MyColors.themeColor : null),
                  ),
                ),
                const SizedBox(width: 15),
                Text(
                  category!.name,
                  style: MyStyles.black16Normal.copyWith(color: Theme.of(context).hintColor),
                ),
                const Spacer(),
                Container(
                  height: 37,
                  width: 37,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: category!.isSelected! ? MyColors.white : Theme.of(context).buttonColor),
                  child: Center(
                    child: Image.asset(MyImages.tickIcon, color: category!.isSelected! ? MyColors.themeColor : null),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
