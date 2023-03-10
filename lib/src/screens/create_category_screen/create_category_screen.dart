// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:googleapis/drive/v3.dart' as ga;
import 'package:googleapis/drive/v3.dart';
import 'package:skendy/cloud_store/google_driver.dart';
import 'package:skendy/models/category_model.dart';
import 'package:skendy/src/custom_widgets/custom_app_bar.dart';
import 'package:skendy/src/custom_widgets/custom_button.dart';
import 'package:skendy/src/custom_widgets/custom_chips.dart';
import 'package:skendy/src/custom_widgets/snackbar.dart';
import 'package:skendy/src/database_helper/database_helper.dart';
import 'package:skendy/src/utils/global.dart';
import 'package:skendy/src/utils/my_colors.dart';
import 'package:skendy/src/utils/my_images.dart';
import 'package:skendy/src/utils/my_strings.dart';
import 'package:skendy/src/utils/my_style.dart';

class CreateCategory extends StatefulWidget {
  final Function(CategoryModel)? onCreateClick;

  const CreateCategory({Key? key, this.onCreateClick}) : super(key: key);

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  List<String> keywords = ["Hospital", "Gym", "Exercise"];
  TextEditingController keywordsController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  String? icon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(title: MyStrings.createCategory),
              Text(MyStrings.categoryName, style: MyStyles.black14Regular.copyWith(color: Theme.of(context).hintColor)),
              const SizedBox(height: 5),
              Container(
                height: 53,
                width: double.infinity,
                decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: categoryController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: MyStrings.exMedical,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(MyStrings.chooseIcon, style: MyStyles.black14Regular.copyWith(color: Theme.of(context).hintColor)),
              const SizedBox(height: 5),
              DropdownButtonFormField(
                  dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                  decoration: const InputDecoration(),
                  items: Global.iconsList
                      .map((e) => DropdownMenuItem<String>(
                            value: e.id,
                            child: Row(
                              children: [
                                e.icon,
                                const SizedBox(width: 10),
                                Text("${e.display}"),
                              ],
                            ),
                          ))
                      .toList(),
                  onChanged: (c) {
                    icon = c.toString();
                    setState(() {

                    });
                  }),
              const SizedBox(height: 15),
              Text(MyStrings.addKeyword, style: MyStyles.black14Regular.copyWith(color: Theme.of(context).hintColor)),
              const SizedBox(height: 5),
              Container(
                height: 53,
                width: double.infinity,
                decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: keywordsController,
                        decoration: const InputDecoration(border: InputBorder.none, hintText: MyStrings.keywordHeart),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          if (keywordsController.text.isEmpty) {
                            snackBar(context, MyStrings.keywordIsEmpty);
                            return;
                          } else if (keywords.contains(keywordsController.text.trim())) {
                            snackBar(context, MyStrings.keywordIsAlreadyAdded);
                            return;
                          } else {
                            keywords.add(keywordsController.text.trim());
                            keywordsController.clear();
                            setState(() {});
                          }
                        },
                        child: const Text("ADD")),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(10)),
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Wrap(
                      children: List.generate(keywords.length, (index) {
                        return CustomChips(
                          text: keywords[index],
                          onRemoveClick: () {
                            keywords.removeAt(index);
                            setState(() {});
                          },
                        );
                      }),
                    )),
              ),
              const SizedBox(height: 400),
              CustomButton(
                  text: MyStrings.create,
                  onTap: () async {
                    if (categoryController.text.isEmpty) {
                      snackBar(context, "Please enter category name");
                      return;
                    }
                    if (icon == null) {
                      snackBar(context, "Please select icon");
                      return;
                    }
                    if (keywords.length < 5) {
                      snackBar(context, "Keywords needs to be at least 5.");
                      return;
                    }
                    CategoryModel c = CategoryModel(
                        isSelected: false,
                        title: categoryController.text,
                        bgColor: MyColors.grayCont,
                        icon: icon,
                        keywords: keywords);
                    widget.onCreateClick!(c);
                    Map<String, dynamic> map = {
                      DatabaseHelper.fieldName: categoryController.text,
                      DatabaseHelper.fieldKeywords: keywords,
                      DatabaseHelper.fieldDelete: false,
                      DatabaseHelper.fieldIconName: icon,
                    };
                    await DatabaseHelper.addCategory(FirebaseAuth.instance.currentUser!, map);
                    DriveApi? api = await GoogleDrive.getDriveApi(context);
                    ga.File parentFolderId = await GoogleDrive.getParentFolderId(api, context, foldName: categoryController.text);
                    String? childFolder = await GoogleDrive.createChildFolder(context, api, parentFolderId, categoryController.text);

                    if (childFolder != null) {
                      snackBar(context, "Category Created successfully");
                    }
                    Navigator.of(context).pop();
                  },
                  border: true)
            ],
          ),
        ),
      ),
    );
  }
}
