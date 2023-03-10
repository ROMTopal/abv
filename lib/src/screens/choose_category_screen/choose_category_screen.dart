import 'package:flutter/material.dart';
import 'package:skendy/src/custom_widgets/custom_card.dart';
import 'package:skendy/src/utils/my_colors.dart';
import 'package:skendy/src/utils/my_images.dart';
import 'package:skendy/src/utils/my_strings.dart';
import 'package:skendy/src/utils/my_style.dart';

class ChooseCategoryScreen extends StatefulWidget {
  const ChooseCategoryScreen({Key? key}) : super(key: key);

  @override
  State<ChooseCategoryScreen> createState() => _ChooseCategoryScreenState();
}

class _ChooseCategoryScreenState extends State<ChooseCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteBg,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Text(MyStrings.chooseCategory, style: MyStyles.black18Normal),
              const SizedBox(height: 20),
              Text(
                MyStrings.chooseTheCategories,
                style: MyStyles.black20Normal.copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Text(MyStrings.chooseCategory, style: MyStyles.black16Regular),
                  const Spacer(),
                  Container(
                    decoration:
                        BoxDecoration(color: MyColors.transparent, border: Border.all(color: MyColors.themeColor), borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: Center(
                        child: Text(MyStrings.create, style: MyStyles.blue14Regular),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              CustomCard(onTap: () {}, icon: MyImages.taxIcon, color: MyColors.lightPink, text: MyStrings.tax),
            ],
          ),
        ),
      ),
    );
  }
}
