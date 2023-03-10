import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skendy/src/custom_widgets/custom_app_bar.dart';
import 'package:skendy/src/custom_widgets/switch_card.dart';
import 'package:skendy/src/database_helper/database_helper.dart';
import 'package:skendy/src/database_helper/update_methods.dart';
import 'package:skendy/src/utils/my_strings.dart';
import 'package:skendy/src/utils/my_style.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({Key? key}) : super(key: key);

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  bool fileName = false;
  bool autoDel = false;
  bool autoExpo = false;
  bool autoDocument = false;

  String? ocrLanguage;
  List listItem1 = ["ENGLISH", "DUTCH", "FRENCH", "GERMAN"];

  String? appLanguage;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: StreamBuilder<DocumentSnapshot>(

          stream: FirebaseFirestore.instance.collection(DatabaseHelper.collectionUserPreferences).doc(user!.uid).snapshots(),
          builder: (_,AsyncSnapshot<DocumentSnapshot> snapshot){
            if(!snapshot.hasData) return Text("Loading..");
            print("${snapshot.data!.get('autoDelete')}");
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(title: MyStrings.general),
                SwitchCard(
                  text: MyStrings.fileName,
                  value: fileName,
                  onTap: (bool s) {
                    setState(() {
                      fileName = s;
                      print(fileName);
                    });
                  },
                ),
                SwitchCard(
                  text: MyStrings.autoDelete,
                  value: snapshot.data!.get(DatabaseHelper.fieldAutoDelete),
                  onTap: (bool s) async {
                    autoDel = s;
                    print(autoDel);
                    Map<String, dynamic> map = updateAutoDelete(s);
                    await DatabaseHelper.updateUserPrefParticularValue(user!, map);
                    setState(() {});
                  },
                ),
                SwitchCard(
                  text: MyStrings.automaticDoc,
                  value: snapshot.data!.get(DatabaseHelper.fieldAutomaticDocumentDetection),
                  onTap: (bool s) async {
                    autoDocument = s;
                    print(autoDocument);
                    Map<String, dynamic> map = updateAutoDocDetection(s);
                    await DatabaseHelper.updateUserPrefParticularValue(user!, map);
                    setState(() {});
                  },
                ),
                const SizedBox(height: 10),
                Text(MyStrings.ocr, style: MyStyles.black16Normal.copyWith(color: Theme.of(context).hintColor)),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  height: 72,
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      border: Border.all(width: 1.5, color: Theme.of(context).dividerColor),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: DropdownButton(
                      dropdownColor: Theme.of(context).cardColor,
                      hint: Text(
                        MyStrings.ocr,
                        style: MyStyles.black16Normal.copyWith(color: Theme.of(context).hintColor),
                      ),
                      value: snapshot.data!.get(DatabaseHelper.fieldOcrLanguage),
                      isExpanded: true,
                      style: MyStyles.black16Normal,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      underline: const SizedBox(),
                      onChanged: (newVal) async {
                        ocrLanguage = newVal.toString();
                        Map<String, dynamic> map = updateOcrLanguage(ocrLanguage!.toUpperCase());
                        await DatabaseHelper.updateUserPrefParticularValue(user!, map);
                        setState(() {});
                      },
                      items: listItem1.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem, style: TextStyle(color: Theme.of(context).hintColor)),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  MyStrings.appLanguage,
                  style: MyStyles.black16Normal.copyWith(color: Theme.of(context).hintColor),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  height: 72,
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      border: Border.all(width: 1.5, color: Theme.of(context).dividerColor),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: DropdownButton(
                      dropdownColor: Theme.of(context).cardColor,
                      hint: Text(
                        MyStrings.appLanguage,
                        style: MyStyles.black16Normal.copyWith(color: Theme.of(context).hintColor),
                      ),
                      value: snapshot.data!.get(DatabaseHelper.fieldAppLanguage),
                      isExpanded: true,
                      style: MyStyles.black16Normal,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      underline: const SizedBox(),
                      onChanged: (newVal) async {
                        appLanguage = newVal.toString();
                        Map<String, dynamic> map = updateAppLanguage(appLanguage!.toUpperCase());
                        await DatabaseHelper.updateUserPrefParticularValue(user!, map);
                        setState(() {});
                      },
                      items: listItem1.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem, style: TextStyle(color: Theme.of(context).hintColor)),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
