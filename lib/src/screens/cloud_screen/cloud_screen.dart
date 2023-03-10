import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:skendy/cloud_store/google_driver.dart';
import 'package:googleapis/drive/v3.dart' as ga;
import 'package:skendy/models/custom_category_model.dart';
import 'package:skendy/src/custom_widgets/category_card.dart';
import 'package:skendy/src/custom_widgets/custom_app_bar.dart';
import 'package:skendy/src/database_helper/database_helper.dart';
import 'package:skendy/src/screens/action_screen/action_screen.dart';
import 'package:skendy/src/screens/create_category_screen/create_category_screen.dart';
import 'package:skendy/src/utils/global.dart';
import 'package:skendy/src/utils/my_colors.dart';
import 'package:skendy/src/utils/my_images.dart';
import 'package:skendy/src/utils/my_strings.dart';
import 'package:skendy/src/utils/my_style.dart';

import '../../custom_widgets/snackbar.dart';

class CloudScreen extends StatefulWidget {
  const CloudScreen({Key? key}) : super(key: key);

  @override
  State<CloudScreen> createState() => _CloudScreenState();
}

class _CloudScreenState extends State<CloudScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  List<CustomCategory> customCatList = [];

  Future<List<CustomCategory>> fetchCustomCategory() async {
    final DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(DatabaseHelper.collectionUsers).doc(auth.currentUser!.uid);
    final docSnapshot = await docRef.get();
    final List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(docSnapshot.data()![DatabaseHelper.fieldCustomCategories]);
    customCatList = data.map((e) => CustomCategory.fromMap(e)).toList();
    setState(() {});
    return data.map((e) => CustomCategory.fromMap(e)).toList();
  }

  List<CustomCategory> categoryList = [
    CustomCategory(iconName: MyImages.taxIcon, bgColor: const Color(0xffF5DBF7), name: "Tax", isSelected: false),
    CustomCategory(iconName: MyImages.healthIcon, bgColor: const Color(0xffC9E7F8), name: "Healthcare", isSelected: false),
    CustomCategory(iconName: MyImages.jobIcon, bgColor: const Color(0xffE9F9EE), name: "Job", isSelected: false),
    CustomCategory(iconName: MyImages.schoolIcon, bgColor: const Color(0xffFDF4EB), name: "School", isSelected: false),
    CustomCategory(iconName: MyImages.utilitiesIcon, bgColor: const Color(0xffC9E7F8), name: "Utilities", isSelected: false),
    CustomCategory(iconName: MyImages.housingIcon, bgColor: const Color(0xffFFF8E6), name: "Housing", isSelected: false),
    CustomCategory(iconName: MyImages.investmentsIcon, bgColor: const Color(0xffF5DBF7), name: "Investments", isSelected: false),
    CustomCategory(iconName: MyImages.manicipaltyIcon, bgColor: const Color(0xffE9F9EE), name: "Municipality", isSelected: false),
    CustomCategory(iconName: MyImages.businessIcon, bgColor: const Color(0xffFDF4EB), name: "Business", isSelected: false),
    CustomCategory(iconName: MyImages.lawsuiteIcon, bgColor: const Color(0xffC9E7F8), name: "Lawsuit", isSelected: false),
    CustomCategory(iconName: MyImages.miscellaneousIcon, bgColor: const Color(0xffFFF8E6), name: "Miscellaneous", isSelected: false),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCustomCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CustomAppBar(
                widget: GestureDetector(
                  onTap: () async {
                    for(int i=0;i<categoryList.length;i++){

                      if(categoryList[i].isSelected==true)
                        {
                          DriveApi? api = await GoogleDrive.getDriveApi(context);
                          ga.File parentFolderId = await GoogleDrive.getParentFolderId(api, context, foldName: categoryList[i].name);
                          String? childFolder = await GoogleDrive.createChildFolder(context, api, parentFolderId,categoryList[i].name);

                          if (childFolder != null) {
                            print("$childFolder   ${categoryList[i].name} created");
                            snackBar(context, "Category Created successfully");
                          }
                        }
                    }
                    // Navigator.push(context, MaterialPageRoute(builder: (_) => const ActionScreen()));
                  },
                  child: Container(
                    height: 36,
                    width: 95,
                    decoration: BoxDecoration(color: MyColors.themeColor, borderRadius: BorderRadius.circular(10)),
                    child: Center(child: Text(MyStrings.approved, style: MyStyles.white14Regular)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                MyStrings.chooseTheCategories,
                style: MyStyles.black20Normal.copyWith(fontWeight: FontWeight.w500, color: Theme.of(context).hintColor),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Text(
                    MyStrings.chooseCategory,
                    style: MyStyles.black16Regular.copyWith(color: Theme.of(context).hintColor),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => CreateCategory(
                                  onCreateClick: (c) {
                                    fetchCustomCategory();
                                    setState(() {});
                                  },
                                )),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: MyColors.transparent, border: Border.all(color: MyColors.themeColor), borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: Center(
                          child: Text(
                            MyStrings.create,
                            style: MyStyles.blue14Regular
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              if (customCatList.isNotEmpty) ...[
                Row(
                  children: [
                    Text(
                      "Custom Category",
                      style: MyStyles.black16Regular.copyWith(color: Theme.of(context).hintColor),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: List.generate(customCatList.length, (index) {
                    CustomCategory c = customCatList[index];
                    return CategoryCard(
                      iconModel: Global.getIcon(c.iconName),
                      category: c,
                      onSelect: (c) {
                        setState(() {
                          customCatList[index].isSelected = c;
                        });
                      },
                    );
                  }),
                ),
              ],
              Row(
                children: [
                  Text(
                    "Default Category",
                    style: MyStyles.black16Regular.copyWith(color: Theme.of(context).hintColor),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                children: List.generate(categoryList.length, (index) {
                  CustomCategory c = categoryList[index];
                  return CategoryCard(
                    category: c,
                    onSelect: (c) {
                      setState(() {
                        categoryList[index].isSelected = c;
                      });
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
